package com.company.pm.service;


import com.company.pm.entity.Project;

public interface ProjectsService {
    String NAME = "pm_ProjectsService";

    void startTasksProcesses(Project project);

    void startProjectProcess(Project project);
}