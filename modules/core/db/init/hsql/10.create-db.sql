-- begin PM_PROJECT
create table PM_PROJECT (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(255),
    MANAGER_ID varchar(36),
    DESCRIPTION varchar(255),
    STATE varchar(50),
    --
    primary key (ID)
)^
-- end PM_PROJECT
-- begin PM_COMPANY_GOAL
create table PM_COMPANY_GOAL (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(255),
    --
    primary key (ID)
)^
-- end PM_COMPANY_GOAL
-- begin PM_TASK
create table PM_TASK (
    ID varchar(36) not null,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(255),
    PROJECT_ID varchar(36),
    EXECUTOR_ID varchar(36),
    ESTIMATION integer,
    DESCRIPTION longvarchar,
    START_DATE date,
    END_DATE date,
    STATE varchar(50),
    --
    primary key (ID)
)^
-- end PM_TASK
-- begin PM_PROJECT_USER_LINK
create table PM_PROJECT_USER_LINK (
    PROJECT_ID varchar(36) not null,
    USER_ID varchar(36) not null,
    primary key (PROJECT_ID, USER_ID)
)^
-- end PM_PROJECT_USER_LINK
-- begin PM_TASK_USER_LINK
create table PM_TASK_USER_LINK (
    TASK_ID varchar(36) not null,
    USER_ID varchar(36) not null,
    primary key (TASK_ID, USER_ID)
)^
-- end PM_TASK_USER_LINK
