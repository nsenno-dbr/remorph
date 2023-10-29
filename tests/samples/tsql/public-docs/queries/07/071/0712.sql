-- see https://learn.microsoft.com/en-us/sql/t-sql/statements/alter-server-configuration-transact-sql?view=sql-server-ver16

ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = ON (RESOURCE_POOL = 'pool_name');
GO