package com.company.pm.web.mytasks;

import com.company.pm.entity.Task;
import com.haulmont.cuba.gui.components.AbstractLookup;
import com.haulmont.cuba.gui.components.GroupTable;
import com.haulmont.cuba.gui.components.actions.EditAction;
import com.haulmont.cuba.gui.data.GroupDatasource;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.UUID;

public class MyTaskBrowse extends AbstractLookup {

    @Inject
    private GroupTable<Task> tasksTable;

    @Named("tasksTable.edit")
    private EditAction tasksTableEdit;

    @Inject
    private GroupDatasource<Task, UUID> tasksDs;

    @Override
    public void ready() {
        super.ready();
        tasksTable.expandAll();
        tasksTableEdit.setAfterCommitHandler(entity -> tasksDs.refresh());
    }
}