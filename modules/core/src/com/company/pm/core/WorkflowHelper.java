package com.company.pm.core;

import com.haulmont.bpm.entity.ProcDefinition;
import com.haulmont.bpm.entity.ProcInstance;
import com.haulmont.cuba.core.global.DataManager;
import com.haulmont.cuba.core.global.LoadContext;
import com.haulmont.cuba.security.entity.User;
import org.springframework.stereotype.Component;

import javax.annotation.Nullable;
import javax.inject.Inject;
import java.util.List;
import java.util.UUID;

/**
 * A helper with generic workflow-specific functionality
 */
@Component
public class WorkflowHelper {

    @Inject
    private DataManager dataManager;

    public List<User> findUsersBySecRole(String roleName) {
        LoadContext.Query query = LoadContext.createQuery("select u from sec$User u join u.userRoles ur where ur.role.name = :roleName")
                .setParameter("roleName", roleName);
        return dataManager.loadList(LoadContext.create(User.class).setQuery(query));
    }

    public List<ProcInstance> findActiveProcInstances(UUID entityId, String processCode) {
        LoadContext.Query query = LoadContext.createQuery("select pi from bpm$ProcInstance pi where pi.entityId = :entityId " +
                "and pi.procDefinition.code = :processCode and pi.active = true")
                .setParameter("entityId", entityId)
                .setParameter("processCode", processCode);
        return dataManager.loadList(LoadContext.create(ProcInstance.class).setQuery(query));
    }

    @Nullable
    public ProcDefinition findProcDefinition(String processCode) {
        LoadContext ctx = LoadContext.create(ProcDefinition.class).setView("procDefinition-edit");
        ctx.setQueryString("select pd from bpm$ProcDefinition pd where pd.code = :code")
                .setParameter("code", processCode);
        return (ProcDefinition) dataManager.load(ctx);
    }

}
