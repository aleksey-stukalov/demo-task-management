-- begin PM_PROJECT
alter table PM_PROJECT add constraint FK_PM_PROJECT_MANAGER foreign key (MANAGER_ID) references SEC_USER(ID)^
create index IDX_PM_PROJECT_MANAGER on PM_PROJECT (MANAGER_ID)^
-- end PM_PROJECT
-- begin PM_TASK
alter table PM_TASK add constraint FK_PM_TASK_PROJECT foreign key (PROJECT_ID) references PM_PROJECT(ID)^
alter table PM_TASK add constraint FK_PM_TASK_EXECUTOR foreign key (EXECUTOR_ID) references SEC_USER(ID)^
create index IDX_PM_TASK_PROJECT on PM_TASK (PROJECT_ID)^
create index IDX_PM_TASK_EXECUTOR on PM_TASK (EXECUTOR_ID)^
-- end PM_TASK
-- begin PM_PROJECT_USER_LINK
alter table PM_PROJECT_USER_LINK add constraint FK_PPUL_PROJECT foreign key (PROJECT_ID) references PM_PROJECT(ID)^
alter table PM_PROJECT_USER_LINK add constraint FK_PPUL_USER foreign key (USER_ID) references SEC_USER(ID)^
-- end PM_PROJECT_USER_LINK
-- begin PM_TASK_USER_LINK
alter table PM_TASK_USER_LINK add constraint FK_PTUL_TASK foreign key (TASK_ID) references PM_TASK(ID)^
alter table PM_TASK_USER_LINK add constraint FK_PTUL_USER foreign key (USER_ID) references SEC_USER(ID)^
-- end PM_TASK_USER_LINK
