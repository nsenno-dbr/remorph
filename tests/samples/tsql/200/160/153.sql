-- Uses AdventureWorks

SELECT SalesOrderNumber
FROM (
    SELECT fis.SalesOrderNumber,
        dp.ProductKey,
        dp.EnglishProductName
    FROM DimProduct AS dp
    INNER REPLICATE JOIN FactInternetSales AS fis
        ON dp.ProductKey = fis.ProductKey
    ) AS dTable
ORDER BY SalesOrderNumber;