WITH customer_orders AS (
  SELECT 
    c.c_custkey,
    o.o_orderkey,
    o.o_orderdate
  FROM 
    customer c
  INNER JOIN 
    orders o ON c.c_custkey = o.o_custkey
),
customer_orders_agg AS (
  SELECT 
    c_custkey,
    ARRAY_AGG(o_orderkey ORDER BY o_orderdate) WITHIN GROUP (ORDER BY o_orderkey) AS orders
  FROM 
    customer_orders
  GROUP BY 
    c_custkey
)
SELECT 
  c_custkey,
  orders
FROM 
  customer_orders_agg
LIMIT 10;