-- begin PM_PROJECT
create table PM_PROJECT (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(255) not null,
    MANAGER_ID uuid not null,
    DESCRIPTION varchar(255),
    STATE varchar(50),
    --
    primary key (ID)
)^
-- end PM_PROJECT
-- begin PM_COMPANY_GOAL
create table PM_COMPANY_GOAL (
    ID uuid,
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
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(255) not null,
    PROJECT_ID uuid not null,
    EXECUTOR_ID uuid not null,
    ESTIMATION integer,
    DESCRIPTION text,
    START_DATE date,
    END_DATE date,
    STATE varchar(50),
    --
    primary key (ID)
)^
-- end PM_TASK
-- begin PM_PROJECT_GOAL
create table PM_PROJECT_GOAL (
    ID uuid,
    VERSION integer not null,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(255) not null,
    COMPANY_GOAL_ID uuid not null,
    PROJECT_ID uuid,
    --
    primary key (ID)
)^
-- end PM_PROJECT_GOAL
-- begin PM_PROJECT_USER_LINK
create table PM_PROJECT_USER_LINK (
    PROJECT_ID uuid,
    USER_ID uuid,
    primary key (PROJECT_ID, USER_ID)
)^
-- end PM_PROJECT_USER_LINK
