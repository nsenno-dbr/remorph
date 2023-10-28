-- create a table to store the return values.
create or replace table return_values (str varchar);

-- create a task that sets the return value for the task.
create task set_return_value
  warehouse=return_task_wh
  schedule='1 minute' as
  call system$set_return_value('The quick brown fox jumps over the lazy dog');

-- create a task that identifies the first task as the predecessor task and retrieves the return value set for that task.
create task get_return_value
  warehouse=return_task_wh
  after set_return_value
  as
    insert into return_values values(system$get_predecessor_return_value());


-- Note that if there are multiple predecessor tasks that are enabled, you must specify the name of the task to retrieve the return value for that task.
create task get_return_value_by_pred
  warehouse=return_task_wh
  after set_return_value
  as
    insert into return_values values(system$get_predecessor_return_value('SET_RETURN_VALUE'));

-- resume task (using ALTER TASK ... RESUME).
-- wait for task to run on schedule.

select distinct(str) from return_values;

select distinct(RETURN_VALUE)
  from table(information_schema.task_history())
  where RETURN_VALUE is not NULL;