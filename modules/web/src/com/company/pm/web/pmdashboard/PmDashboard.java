package com.company.pm.web.pmdashboard;

import com.company.pm.entity.Project;
import com.company.pm.entity.Task;
import com.company.pm.entity.TaskState;
import com.haulmont.cuba.core.entity.KeyValueEntity;
import com.haulmont.cuba.gui.components.*;
import com.haulmont.cuba.gui.components.actions.CreateAction;
import com.haulmont.cuba.gui.components.actions.EditAction;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.gui.xml.layout.ComponentsFactory;

import javax.inject.Inject;
import javax.inject.Named;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public class PmDashboard extends AbstractWindow {

    @Inject
    private Table<Project> projectsTable;

    @Inject
    private ComponentsFactory componentsFactory;

    @Inject
    private CollectionDatasource<KeyValueEntity, Object> projectsByGoalsDs;

    @Inject
    private CollectionDatasource<Project, UUID> projectsDs;
    @Named("projectsTable.create")
    private CreateAction projectsTableCreate;

    @Named("projectsTable.edit")
    private EditAction projectsTableEdit;

    @Override
    public void ready() {
        super.ready();
        projectsTable.addGeneratedColumn("progress", project -> {
            HBoxLayout hbox = componentsFactory.createComponent(HBoxLayout.class);
            hbox.setSpacing(true);
            ProgressBar progressBar = componentsFactory.createComponent(ProgressBar.class);
            List<Task> tasks = project.getTasks();
            Integer allTasksEstimation = tasks.stream()
                    .mapToInt(value -> value.getEstimation() != null ? value.getEstimation() : 0)
                    .sum();
            Integer completedTasksEstimation = tasks.stream()
                    .filter(task -> task.getState() == TaskState.COMPLETED)
                    .mapToInt(value -> value.getEstimation() != null ? value.getEstimation() : 0)
                    .sum();
            float progressValue = 0;
            if (allTasksEstimation != 0) {
                progressValue = (float )completedTasksEstimation / allTasksEstimation;
            }
            progressBar.setValue(progressValue);
            hbox.add(progressBar);
            Label label = componentsFactory.createComponent(Label.class);
            BigDecimal bd = new BigDecimal(Float.toString(progressValue * 100));
            bd = bd.setScale(0, BigDecimal.ROUND_HALF_UP);
            label.setValue(bd + " %");
            hbox.add(label);
            return hbox;
        });

        projectsTable.addGeneratedColumn("tasksNumber", project -> {
            Label label = componentsFactory.createComponent(Label.class);
            List<Task> tasks = project.getTasks();
            long completedTasksCount = tasks.stream()
                    .filter(task -> task.getState() == TaskState.COMPLETED)
                    .count();
            label.setValue(completedTasksCount + " / " + tasks.size());
            return label;
        });

        projectsTableCreate.setAfterCommitHandler(entity -> projectsDs.refresh());
        projectsTableEdit.setAfterCommitHandler(entity -> projectsDs.refresh());
    }

    public void refreshProjectsByGoals() {
        projectsByGoalsDs.refresh();
    }
}