-- see https://learn.microsoft.com/en-us/sql/t-sql/functions/eomonth-transact-sql?view=sql-server-ver16

DECLARE @date VARCHAR(255) = '12/1/2011';  
SELECT EOMONTH ( @date ) AS Result;  
GO