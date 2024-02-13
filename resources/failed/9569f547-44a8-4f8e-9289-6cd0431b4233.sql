SELECT orderdate, ARRAY_AGG(orderkey ORDER BY shipdate) WITHIN GROUP (ORDER BY custkey) AS orderkeys
FROM orders
GROUP BY orderdate