-- see https://learn.microsoft.com/en-us/sql/t-sql/statements/alter-database-transact-sql?view=sql-server-ver16

ALTER DATABASE <database_name>
    MODIFY (SERVICE_OBJECTIVE = 'GP_Gen5_8');