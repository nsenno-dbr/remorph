-- see https://learn.microsoft.com/en-us/sql/t-sql/statements/deny-database-permissions-transact-sql?view=sql-server-ver16

USE AdventureWorks2022;
DENY VIEW DEFINITION TO CarmineEs CASCADE;
GO