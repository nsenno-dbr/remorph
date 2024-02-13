WITH customer_orders AS (
  SELECT c.c_custkey,
         o.o_orderkey,
         o.o_orderdate,
         o.o_totalprice
  FROM customer c
  JOIN orders o ON c.c_custkey = o.o_custkey
),
customer_order_totals AS (
  SELECT c_custkey,
         ARRAY_AGG(o_orderkey ORDER BY o_totalprice DESC) WITHIN GROUP (ORDER BY o_orderdate) AS ordered_orders
  FROM customer_orders
  GROUP BY c_custkey
)
SELECT c_custkey,
       ordered_orders
FROM customer_order_totals;