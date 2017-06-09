package com.company.pm.service;

import com.company.pm.core.Projects;
import com.company.pm.entity.Project;
import org.springframework.stereotype.Service;

import javax.inject.Inject;

@Service(ProjectsService.NAME)
public class ProjectsServiceBean implements ProjectsService {

    @Inject
    private Projects projects;

    @Override
    public void startTasksProcesses(Project project) {
        projects.startTasksProcesses(project);
    }

    @Override
    public void startProjectProcess(Project project) {
        projects.startProjectProcess(project);
    }
}