package com.company.pm.core;

import com.company.pm.entity.Project;

import java.util.UUID;

/**
 * Bean that contains methods required by business process for task and project entity.
 */
public interface Projects {

    String NAME = "pm_Projects";

    void updateTaskState(UUID taskId, String enumValue);

    void updateProjectState(UUID entityId, String enumValue);

    /**
     * Method finds a process for the project that is related to the task and sends a given signal to the project
     * process
     */
    void signalRelatedProject(UUID taskId, String signalName);

    /**
     * Method finds processes for all tasks of the given project and sends a signal to each of this process
     * process
     */
    void signalRelatedTasks(UUID projectId, String signalName);

    /**
     * Method returns true if all tasks are in a given state
     */
    boolean isAllTasksInState(UUID projectId, String stateEnumValue);

    /**
     * Method creates a process instance with process actors for the given project and starts the business process
     */
    void startProjectProcess(Project project);

    /**
     * Method creates process instances with process actors for all tasks of the given project and starts the business
     * process.
     */
    void startTasksProcesses(Project project);
}
