-- update PM_TASK set PROJECT_ID = <default_value> where PROJECT_ID is null ;
alter table PM_TASK alter column PROJECT_ID set not null ;
