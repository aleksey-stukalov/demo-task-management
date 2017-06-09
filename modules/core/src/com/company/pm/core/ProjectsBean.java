package com.company.pm.core;

import com.company.pm.entity.Project;
import com.company.pm.entity.ProjectState;
import com.company.pm.entity.Task;
import com.company.pm.entity.TaskState;
import com.haulmont.bpm.core.ProcessRuntimeManager;
import com.haulmont.bpm.entity.ProcActor;
import com.haulmont.bpm.entity.ProcDefinition;
import com.haulmont.bpm.entity.ProcInstance;
import com.haulmont.bpm.entity.ProcRole;
import com.haulmont.cuba.core.EntityManager;
import com.haulmont.cuba.core.Persistence;
import com.haulmont.cuba.core.Transaction;
import com.haulmont.cuba.core.entity.BaseUuidEntity;
import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.core.global.CommitContext;
import com.haulmont.cuba.core.global.DataManager;
import com.haulmont.cuba.core.global.Metadata;
import com.haulmont.cuba.security.entity.User;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.Execution;
import org.springframework.stereotype.Component;

import javax.inject.Inject;
import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 */
@Component(Projects.NAME)
public class ProjectsBean implements Projects {

    @Inject
    private ProcessRuntimeManager processRuntimeManager;

    @Inject
    private DataManager dataManager;

    @Inject
    private Metadata metadata;

    @Inject
    private Persistence persistence;

    @Inject
    private RuntimeService runtimeService;

    @Inject
    private WorkflowHelper workflowHelper;

    @Override
    public void updateTaskState(UUID taskId, String enumValue) {
        try (Transaction tx = persistence.createTransaction()) {
            Task task = persistence.getEntityManager().find(Task.class, taskId);
            if (task != null) {
                task.setState(TaskState.valueOf(enumValue));
            }
            tx.commit();
        }
    }

    @Override
    public void updateProjectState(UUID entityId, String enumValue) {
        try (Transaction tx = persistence.createTransaction()) {
            Project project = persistence.getEntityManager().find(Project.class, entityId);
            if (project != null) {
                project.setState(ProjectState.valueOf(enumValue));
            }
            tx.commit();
        }
    }

    @Override
    public void signalRelatedProject(UUID taskId, String signalName) {
        try (Transaction tx = persistence.getTransaction()) {
            EntityManager em = persistence.getEntityManager();
            Task task = em.find(Task.class, taskId);
            if (task != null) {
                List<ProcInstance> procInstances = em.createQuery("select pi from bpm$ProcInstance pi " +
                        "where pi.entityId = :entityId and pi.active = true", ProcInstance.class)
                        .setParameter("entityId", task.getProject().getId())
                        .getResultList();
                if (procInstances.isEmpty()) {
                    throw new RuntimeException("ProcInstance for project " + task.getProject().getId() + " not found");
                }
                ProcInstance procInstance = procInstances.get(0);
                Execution execution = runtimeService.createExecutionQuery()
                        .processInstanceId(procInstance.getActProcessInstanceId())
                        .signalEventSubscriptionName(signalName)
                        .singleResult();
                runtimeService.signalEventReceived(signalName, execution.getId());
            }
            tx.commit();
        }
    }

    @Override
    public void signalRelatedTasks(UUID projectId, String signalName) {
        try (Transaction tx = persistence.getTransaction()) {
            EntityManager em = persistence.getEntityManager();
                List<ProcInstance> procInstances = em.createQuery(
                        "select pi from bpm$ProcInstance pi join pm$Task t on t.id = pi.entityId " +
                                "where t.project.id = :projectId and pi.active = true", ProcInstance.class)
                        .setParameter("projectId", projectId)
                        .getResultList();
                if (procInstances.isEmpty()) {
                    throw new RuntimeException("Error on signaling related tasks. No proc instances found");
                }
                for (ProcInstance procInstance : procInstances) {
                    Execution execution = runtimeService.createExecutionQuery()
                            .processInstanceId(procInstance.getActProcessInstanceId())
                            .signalEventSubscriptionName(signalName)
                            .singleResult();
                    runtimeService.signalEventReceived(signalName, execution.getId());
                }
            tx.commit();
        }
    }

    @Override
    public boolean isAllTasksInState(UUID projectId, String stateEnumValue) {
        try (Transaction tx = persistence.createTransaction()) {
            Project project = persistence.getEntityManager().find(Project.class, projectId);
            TaskState state = TaskState.valueOf(stateEnumValue);
            if (project != null) {
                for (Task task : project.getTasks()) {
                    if (task.getState() != state) return false;
                }
            }
            tx.commit();
        }
        return true;
    }

    @Override
    public void startProjectProcess(Project project) {
        ProcDefinition projectProcDefinition = workflowHelper.findProcDefinition(WfConstants.PROJECT_PROCESS_CODE);

        if (projectProcDefinition == null) {
            throw new RuntimeException("ProcessDefinition not found: " + WfConstants.PROJECT_PROCESS_CODE);
        }

        ProcRole managerRole = projectProcDefinition.getProcRoles().stream()
                .filter(procRole -> WfConstants.MANAGER_PROC_ROLE.equals(procRole.getCode()))
                .findFirst().orElseThrow(() -> new RuntimeException("ProcRole not found: " + WfConstants.MANAGER_PROC_ROLE));

        ProcRole projectOfficeEmployeeRole = projectProcDefinition.getProcRoles().stream()
                .filter(procRole -> WfConstants.PROJECT_OFFICE_EMPLOYEE_PROC_ROLE.equals(procRole.getCode()))
                .findFirst().orElseThrow(() -> new RuntimeException("ProcRole not found: " + WfConstants.PROJECT_OFFICE_EMPLOYEE_PROC_ROLE));

        CommitContext commitContext = new CommitContext();

        ProcInstance procInstance = createProcInstance(projectProcDefinition, project);
        commitContext.addInstanceToCommit(procInstance);

        commitContext.addInstanceToCommit(createProcActor(project.getManager(), managerRole, procInstance));

        workflowHelper.findUsersBySecRole(WfConstants.PROJECT_OFFICE_EMPLOYEE_SEC_ROLE).forEach(user ->
                commitContext.addInstanceToCommit(createProcActor(user, projectOfficeEmployeeRole, procInstance)));

        Set<Entity> commited = dataManager.commit(commitContext);
        commited.stream()
                .filter(entity -> entity instanceof ProcInstance)
                .forEach(pi -> processRuntimeManager.startProcess((ProcInstance) pi, "", null));
    }

    @Override
    public void startTasksProcesses(Project project) {
        ProcDefinition taskProcDefinition = workflowHelper.findProcDefinition(WfConstants.TASK_PROCESS_CODE);
        if (taskProcDefinition == null) {
            throw new RuntimeException("ProcessDefinition not found: " + WfConstants.TASK_PROCESS_CODE);
        }

        ProcRole executorRole = taskProcDefinition.getProcRoles().stream()
                .filter(procRole -> WfConstants.EXECUTOR_PROC_ROLE.equals(procRole.getCode()))
                .findFirst().orElseThrow(() -> new RuntimeException("ProcRole not found: " + WfConstants.EXECUTOR_PROC_ROLE));

        ProcRole managerRole = taskProcDefinition.getProcRoles().stream()
                .filter(procRole -> WfConstants.MANAGER_PROC_ROLE.equals(procRole.getCode()))
                .findFirst().orElseThrow(() -> new RuntimeException("ProcRole not found: " + WfConstants.MANAGER_PROC_ROLE));

        CommitContext commitContext = new CommitContext();

        for (Task task : project.getTasks()) {
            ProcInstance procInstance = createProcInstance(taskProcDefinition, task);
            commitContext.addInstanceToCommit(procInstance);

            commitContext.addInstanceToCommit(createProcActor(task.getExecutor(), executorRole, procInstance));
            commitContext.addInstanceToCommit(createProcActor(project.getManager(), managerRole, procInstance));
        }

        Set<Entity> commited = dataManager.commit(commitContext);
        commited.stream()
                .filter(entity -> entity instanceof ProcInstance)
                .forEach(procInstance -> processRuntimeManager.startProcess((ProcInstance) procInstance, "", null));
    }

    private ProcActor createProcActor(User user, ProcRole procRole, ProcInstance procInstance) {
        ProcActor managerProcActor = metadata.create(ProcActor.class);
        managerProcActor.setUser(user);
        managerProcActor.setProcInstance(procInstance);
        managerProcActor.setProcRole(procRole);
        return managerProcActor;
    }

    private ProcInstance createProcInstance(ProcDefinition procDefinition, BaseUuidEntity entity) {
        ProcInstance procInstance = metadata.create(ProcInstance.class);
        procInstance.setProcDefinition(procDefinition);
        procInstance.setEntityId(entity.getUuid());
        procInstance.setEntityName(entity.getMetaClass().getName());
        return procInstance;
    }
}
