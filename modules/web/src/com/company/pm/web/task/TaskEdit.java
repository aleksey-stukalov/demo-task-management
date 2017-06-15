package com.company.pm.web.task;

import com.company.pm.core.WfConstants;
import com.company.pm.entity.ProjectState;
import com.company.pm.entity.Task;
import com.company.pm.entity.TaskState;
import com.company.pm.service.WorkflowService;
import com.haulmont.bpm.gui.procactions.ProcActionsFrame;
import com.haulmont.cuba.core.global.PersistenceHelper;
import com.haulmont.cuba.gui.components.AbstractEditor;
import com.haulmont.cuba.gui.components.FieldGroup;
import com.haulmont.cuba.gui.components.GroupBoxLayout;
import com.haulmont.cuba.gui.components.RichTextArea;
import com.haulmont.cuba.security.global.UserSession;

import javax.inject.Inject;

public class TaskEdit extends AbstractEditor<Task> {

    @Inject
    private ProcActionsFrame procActionsFrame;

    @Inject
    private GroupBoxLayout procActionsGroupBox;

    @Inject
    private FieldGroup fieldGroup;

    @Inject
    private RichTextArea descriptionTextArea;

    @Inject
    private UserSession userSession;

    @Inject
    private WorkflowService workflowService;

    @Override
    public void ready() {
        super.ready();
        if (workflowService.findActiveProcInstances(getItem().getId(), WfConstants.TASK_PROCESS_CODE).isEmpty()) {
            procActionsGroupBox.setVisible(false);
        } else {
            procActionsFrame.initializer()
                    .setStartProcessEnabled(false)
                    .setBeforeCompleteTaskPredicate(this::commit)
                    .setAfterCompleteTaskListener(() -> {
                        showNotification(getMessage("actionCompleted"));
                        close(COMMIT_ACTION_ID);
                    })
                    .setTaskInfoEnabled(false)
                    .init(WfConstants.TASK_PROCESS_CODE, getItem());
        }

        setUiComponentsAccess();
    }

    protected void setUiComponentsAccess() {
        fieldGroup.getFields().forEach(fieldConfig -> fieldConfig.setEditable(false));

        if (PersistenceHelper.isNew(getItem())) {
            fieldGroup.getFieldNN("name").setEditable(true);
            fieldGroup.getFieldNN("project").setEditable(true);
            fieldGroup.getFieldNN("executor").setEditable(true);
            descriptionTextArea.setEditable(true);
        } else if (userSession.getCurrentOrSubstitutedUser().equals(getItem().getExecutor())) {
            if (TaskState.ESTIMATION.equals(getItem().getState())) {
//            switch (getItem().getState()) {
//                case ESTIMATION:
                    fieldGroup.getFieldNN("estimation").setEditable(true);
                    fieldGroup.getFieldNN("estimation").setRequired(true);
//                    break;
            }
        } else if (userSession.getCurrentOrSubstitutedUser().equals(getItem().getProject().getManager())) {
            fieldGroup.getFieldNN("name").setEditable(true);
            fieldGroup.getFieldNN("executor").setEditable(true);
            descriptionTextArea.setEditable(true);
            if (TaskState.ESTIMATED.equals(getItem().getState())) {
//            switch (getItem().getState()) {
//                case ESTIMATED:
                    if (getItem().getProject().getState() == ProjectState.EXECUTION) {
                        fieldGroup.getFieldNN("startDate").setRequired(true);
                        fieldGroup.getFieldNN("startDate").setEditable(true);
                        fieldGroup.getFieldNN("endDate").setEditable(true);
                        fieldGroup.getFieldNN("endDate").setRequired(true);
                    }
//                    break;
            }
        }
    }
}