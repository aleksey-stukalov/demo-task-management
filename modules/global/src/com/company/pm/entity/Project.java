package com.company.pm.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import com.haulmont.cuba.security.entity.User;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.chile.core.annotations.NamePattern;
import javax.persistence.OneToMany;
import com.haulmont.chile.core.annotations.Composition;
import com.haulmont.cuba.core.entity.annotation.OnDelete;
import com.haulmont.cuba.core.global.DeletePolicy;
import javax.validation.constraints.NotNull;

@NamePattern("%s|name")
@Table(name = "PM_PROJECT")
@Entity(name = "pm$Project")
public class Project extends StandardEntity {
    private static final long serialVersionUID = 3670048276468846648L;

    @NotNull
    @Column(name = "NAME", nullable = false)
    protected String name;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "MANAGER_ID")
    protected User manager;

    @JoinTable(name = "PM_PROJECT_USER_LINK",
        joinColumns = @JoinColumn(name = "PROJECT_ID"),
        inverseJoinColumns = @JoinColumn(name = "USER_ID"))
    @ManyToMany
    protected List<User> administrators;

    @Column(name = "DESCRIPTION")
    protected String description;

    @Composition
    @OnDelete(DeletePolicy.CASCADE)
    @OneToMany(mappedBy = "project")
    protected List<Task> tasks;

    @Column(name = "STATE")
    protected String state;

    @Composition
    @OnDelete(DeletePolicy.CASCADE)
    @OneToMany(mappedBy = "project")
    protected List<ProjectGoal> goals;

    public void setGoals(List<ProjectGoal> goals) {
        this.goals = goals;
    }

    public List<ProjectGoal> getGoals() {
        return goals;
    }


    public void setState(ProjectState state) {
        this.state = state == null ? null : state.getId();
    }

    public ProjectState getState() {
        return state == null ? null : ProjectState.fromId(state);
    }


    public void setTasks(List<Task> tasks) {
        this.tasks = tasks;
    }

    public List<Task> getTasks() {
        return tasks;
    }


    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setManager(User manager) {
        this.manager = manager;
    }

    public User getManager() {
        return manager;
    }

    public void setAdministrators(List<User> administrators) {
        this.administrators = administrators;
    }

    public List<User> getAdministrators() {
        return administrators;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }


}