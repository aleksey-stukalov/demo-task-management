package com.company.pm.service;


import com.haulmont.bpm.entity.ProcInstance;
import com.haulmont.cuba.security.entity.User;

import java.util.List;
import java.util.UUID;

/**
 * Helper with workflow releted methods.
 */
public interface WorkflowService {
    String NAME = "pm_WorkflowService";

    List<User> findUsersByRole(String roleName);

    List<ProcInstance> findActiveProcInstances(UUID entityId, String processCode);
}