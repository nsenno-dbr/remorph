WITH
  customer_orders AS (
    SELECT
      c.c_custkey,
      o.o_orderkey,
      o.o_orderdate
    FROM
      customer c
      JOIN orders o ON c.c_custkey = o.o_custkey
  ),
  customer_recent_orders AS (
    SELECT
      c.c_custkey,
      ARRAY_AGG(o.o_orderkey) WITHIN GROUP (ORDER BY o.o_orderdate DESC) AS recent_orders
    FROM
      customer_orders co
      JOIN orders o ON co.o_orderkey = o.o_orderkey
    GROUP BY
      c.c_custkey
  )
SELECT
  c.c_custkey,
  c.c_name,
  cor.recent_orders
FROM
  customer c
  JOIN customer_recent_orders cor ON c.c_custkey = cor.c_custkey;