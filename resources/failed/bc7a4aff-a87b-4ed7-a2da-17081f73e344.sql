WITH customer_orders AS (
  SELECT c.c_custkey,
         c.c_name,
         ARRAY_AGG(o.o_orderkey ORDER BY o.o_orderdate) AS order_keys
  FROM customer c
  JOIN orders o ON c.c_custkey = o.o_custkey
  GROUP BY c.c_custkey, c.c_name
)
SELECT c.c_name,
       order_keys
FROM customer_orders c
ORDER BY c.c_name;