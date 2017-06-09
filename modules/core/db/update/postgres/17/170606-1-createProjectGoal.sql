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
    NAME varchar(255),
    COMPANY_GOAL_ID uuid,
    PROJECT_ID uuid,
    --
    primary key (ID)
);
