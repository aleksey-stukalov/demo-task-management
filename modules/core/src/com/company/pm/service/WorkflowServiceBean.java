package com.company.pm.service;

import com.company.pm.core.WorkflowHelper;
import com.haulmont.bpm.entity.ProcInstance;
import com.haulmont.cuba.security.entity.User;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;
import java.util.UUID;

@Service(WorkflowService.NAME)
public class WorkflowServiceBean implements WorkflowService {

    @Inject
    private WorkflowHelper workflowHelper;

    @Override
    public List<User> findUsersByRole(String roleName) {
        return workflowHelper.findUsersBySecRole(roleName);
    }

    @Override
    public List<ProcInstance> findActiveProcInstances(UUID entityId, String processCode) {
        return workflowHelper.findActiveProcInstances(entityId, processCode);
    }
}