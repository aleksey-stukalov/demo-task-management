package com.company.pm.web.project;

import com.company.pm.core.WfConstants;
import com.company.pm.entity.Project;
import com.company.pm.entity.ProjectGoal;
import com.company.pm.entity.Task;
import com.company.pm.service.ProjectsService;
import com.company.pm.service.WorkflowService;
import com.haulmont.bpm.gui.procactions.ProcActionsFrame;
import com.haulmont.cuba.core.entity.KeyValueEntity;
import com.haulmont.cuba.core.global.Metadata;
import com.haulmont.cuba.core.global.PersistenceHelper;
import com.haulmont.cuba.gui.ComponentsHelper;
import com.haulmont.cuba.gui.components.*;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.security.entity.User;
import com.haulmont.cuba.security.global.UserSession;
import org.apache.commons.collections.CollectionUtils;

import javax.inject.Inject;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

public class ProjectEdit extends AbstractEditor<Project> {

    @Inject
    private ProcActionsFrame procActionsFrame;

    @Inject
    private ProjectsService projectsService;

    @Inject
    private WorkflowService workflowService;

    @Inject
    private Button startBtn;

    @Inject
    private UserSession userSession;

    @Inject
    private Metadata metadata;

    @Inject
    private CollectionDatasource<ProjectGoal, UUID> goalsDs;

    @Inject
    private CollectionDatasource<KeyValueEntity, Object> tasksGraphDs;

    @Inject
    private CollectionDatasource<Task, UUID> tasksDs;

    @Inject
    private ScrollBoxLayout scrollbox;

    @Inject
    private Table<ProjectGoal> goalsTable;

    @Inject
    private Table<Task> tasksTable;

    public void ready() {
        super.ready();
        tasksDs.addCollectionChangeListener(e -> refreshChart());
        refreshChart();
        initProcActionsFrame();
        setUiComponentsAccess();
    }

    private void initProcActionsFrame() {
        if (PersistenceHelper.isNew(getItem())) {
            procActionsFrame.setVisible(false);
        } else if (workflowService.findActiveProcInstances(getItem().getId(), WfConstants.PROJECT_PROCESS_CODE).isEmpty()) {
            procActionsFrame.setVisible(false);
        } else {
            startBtn.setVisible(false);
            procActionsFrame.initializer()
                    .setBeforeCompleteTaskPredicate(this::commit)
                    .setAfterCompleteTaskListener(() -> {
                        showNotification(getMessage("actionCompleted"));
                        close(COMMIT_ACTION_ID);
                    })
                    .setAfterClaimTaskListener(() -> {
                        showNotification(getMessage("takenInWork"));
                        close(COMMIT_ACTION_ID);
                    })
                    .setTaskInfoEnabled(false)
                    .setStartProcessEnabled(false)
                    .init(WfConstants.PROJECT_PROCESS_CODE, getItem());
        }
    }

    protected void setUiComponentsAccess() {
        if (!isGlobalEditable()) {
            ComponentsHelper.walkComponents(scrollbox, (component, name) -> {
                if (component instanceof Editable) {
                    if (component instanceof TokenList) {
                        component.setEnabled(false);
                    } else {
                        ((Editable) component).setEditable(false);
                    }
                }
            });
            tasksTable.getActions().forEach(action -> action.setEnabled(false));
            goalsTable.getActions().forEach(action -> action.setEnabled(false));
            procActionsFrame.setEnabled(false);
        }
    }

    protected boolean isGlobalEditable() {
        return PersistenceHelper.isNew(getItem()) || userSession.getCurrentOrSubstitutedUser().equals(getItem().getManager());
    }

    @Override
    protected void initNewItem(Project item) {
        super.initNewItem(item);
        item.setManager(userSession.getCurrentOrSubstitutedUser());
    }

    public void startProcess() {
        if (validateProjectBeforeProcessStart() && commit()) {
            Project project = getItem();
            projectsService.startProjectProcess(project);
            projectsService.startTasksProcesses(project);
            showNotification(getMessage("processStarted"), NotificationType.HUMANIZED);
            close(COMMIT_ACTION_ID);
        }
    }

    public boolean validateProjectBeforeProcessStart() {
        if (CollectionUtils.isEmpty(getItem().getTasks())) {
            showNotification(getMessage("tasksNotCreated"), NotificationType.WARNING);
            return false;
        }
        if (workflowService.findUsersByRole(WfConstants.PROJECT_OFFICE_EMPLOYEE_SEC_ROLE).isEmpty()) {
            showNotification(getMessage("projectOfficeEmployeesNotFound"), NotificationType.WARNING);
            return false;
        }
        return true;
    }

    public void addGoal() {
        ProjectGoal projectGoal = metadata.create(ProjectGoal.class);
        projectGoal.setProject(getItem());
        goalsDs.addItem(projectGoal);
    }

    public void refreshChart() {
        tasksGraphDs.clear();
        if (getItem().getTasks() == null) return;
        Map<User, Integer> map = getItem().getTasks().stream()
                .collect(Collectors.groupingBy(Task::getExecutor,
                        Collectors.summingInt(value -> value.getEstimation() != null ? value.getEstimation() : 0)));
        for (Map.Entry<User, Integer> entry : map.entrySet()) {
            KeyValueEntity item = new KeyValueEntity();
            item.setValue("executor", entry.getKey());
            item.setValue("estimation", entry.getValue());
            tasksGraphDs.includeItem(item);
        }
    }
}