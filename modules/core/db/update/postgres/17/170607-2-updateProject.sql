update PM_PROJECT set NAME = '' where NAME is null ;
alter table PM_PROJECT alter column NAME set not null ;
-- update PM_PROJECT set MANAGER_ID = <default_value> where MANAGER_ID is null ;
alter table PM_PROJECT alter column MANAGER_ID set not null ;
