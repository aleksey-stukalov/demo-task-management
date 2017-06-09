package com.company.pm.entity;

import com.haulmont.chile.core.datatypes.impl.EnumClass;

import javax.annotation.Nullable;


public enum ProjectState implements EnumClass<String> {

    IDEA("IDEA"),
    ESTIMATED("ESTD"),
    EXECUTION("EXEC"),
    COMPLETED("CMPL");

    private String id;

    ProjectState(String value) {
        this.id = value;
    }

    public String getId() {
        return id;
    }

    @Nullable
    public static ProjectState fromId(String id) {
        for (ProjectState at : ProjectState.values()) {
            if (at.getId().equals(id)) {
                return at;
            }
        }
        return null;
    }
}