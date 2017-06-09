update PM_TASK set NAME = '' where NAME is null ;
alter table PM_TASK alter column NAME set not null ;
-- update PM_TASK set EXECUTOR_ID = <default_value> where EXECUTOR_ID is null ;
alter table PM_TASK alter column EXECUTOR_ID set not null ;
