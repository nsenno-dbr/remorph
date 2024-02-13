WITH 
  cte_orders AS (
    SELECT 
      o_orderkey, 
      o_custkey, 
      o_orderdate
    FROM 
      orders
    WHERE 
      o_orderdate >= '1994-01-01'
      AND o_orderdate < '1995-01-01'
  ),
  cte_lineitem AS (
    SELECT 
      l_orderkey, 
      l_quantity, 
      l_extendedprice
    FROM 
      lineitem
    WHERE 
      l_shipdate >= '1994-01-01'
      AND l_shipdate < '1995-01-01'
  )
SELECT 
  o_custkey, 
  ARRAY_AGG(l_quantity ORDER BY l_extendedprice DESC) WITHIN GROUP (ORDER BY o_orderdate) AS quantities
FROM 
  cte_orders o
JOIN 
  cte_lineitem l ON o.o_orderkey = l.l_orderkey
GROUP BY 
  o_custkey;