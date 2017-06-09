package com.company.pm.entity;

import com.haulmont.chile.core.datatypes.impl.EnumClass;

import javax.annotation.Nullable;


public enum TaskState implements EnumClass<String> {

    ESTIMATION("ESTN"),
    ESTIMATED("ESTD"),
    PLANNED("PLAN"),
    IN_WORK("WORK"),
    COMPLETED("CMPL");

    private String id;

    TaskState(String value) {
        this.id = value;
    }

    public String getId() {
        return id;
    }

    @Nullable
    public static TaskState fromId(String id) {
        for (TaskState at : TaskState.values()) {
            if (at.getId().equals(id)) {
                return at;
            }
        }
        return null;
    }
}