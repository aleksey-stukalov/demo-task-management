package com.company.pm.web.screens;

import com.company.pm.core.WfConstants;
import com.haulmont.cuba.gui.WindowManager;
import com.haulmont.cuba.security.global.UserSession;
import com.haulmont.cuba.web.app.mainwindow.AppMainWindow;

import javax.inject.Inject;

public class ExtAppMainWindow extends AppMainWindow {

    @Inject
    private UserSession userSession;

    @Override
    public void ready() {
        super.ready();
        String screenToOpen = null;
        if (userSession.getRoles().contains(WfConstants.MANAGER_SEC_ROLE)) {
            screenToOpen = "pmdashboard";
        } else if (userSession.getRoles().contains(WfConstants.EXECUTOR_SEC_ROLE)) {
            screenToOpen = "pm$MyTasks.browse";
        } if (userSession.getRoles().contains(WfConstants.PROJECT_OFFICE_EMPLOYEE_SEC_ROLE)) {
            screenToOpen = "bpm$ProcTask.lookup";
        }
        if (screenToOpen != null) {
            openWindow(screenToOpen, WindowManager.OpenType.THIS_TAB);
        }
    }
}