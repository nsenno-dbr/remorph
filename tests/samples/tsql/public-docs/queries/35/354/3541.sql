-- see https://learn.microsoft.com/en-us/sql/t-sql/statements/deny-endpoint-permissions-transact-sql?view=sql-server-ver16

USE master;  
DENY TAKE OWNERSHIP ON ENDPOINT::Shipping83 TO PKomosinski   
    CASCADE;  
GO