package com.company.pm.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.chile.core.annotations.NamePattern;
import javax.validation.constraints.NotNull;

@NamePattern("%s|name")
@Table(name = "PM_PROJECT_GOAL")
@Entity(name = "pm$ProjectGoal")
public class ProjectGoal extends StandardEntity {
    private static final long serialVersionUID = 1647101750096287825L;

    @NotNull
    @Column(name = "NAME", nullable = false)
    protected String name;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "COMPANY_GOAL_ID")
    protected CompanyGoal companyGoal;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PROJECT_ID")
    protected Project project;

    public void setProject(Project project) {
        this.project = project;
    }

    public Project getProject() {
        return project;
    }


    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setCompanyGoal(CompanyGoal companyGoal) {
        this.companyGoal = companyGoal;
    }

    public CompanyGoal getCompanyGoal() {
        return companyGoal;
    }


}