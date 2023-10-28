ALTER DATABASE [AdventureWorksDW2022] ADD FILEGROUP FG2;
ALTER DATABASE [AdventureWorksDW2022]
ADD FILE
(
NAME='FG2_Data',
FILENAME = '/var/opt/mssql/data/AdventureWorksDW2022_Data1.mdf'
)
TO FILEGROUP FG2;
GO
SELECT * INTO [dbo].[FactResellerSalesXL] ON FG2 FROM [dbo].[FactResellerSales];