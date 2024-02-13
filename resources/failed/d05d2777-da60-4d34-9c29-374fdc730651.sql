WITH
  customer_orders AS (
    SELECT
      c.c_custkey,
      o.o_orderkey,
      o.o_orderdate,
      o.o_totalprice
    FROM
      customer c
      JOIN orders o ON c.c_custkey = o.o_custkey
  ),
  customer_total_orders AS (
    SELECT
      c.c_custkey,
      COUNT(DISTINCT o.o_orderkey) AS total_orders
    FROM
      customer c
      JOIN orders o ON c.c_custkey = o.o_custkey
    GROUP BY
      c.c_custkey
  ),
  customer_order_totals AS (
    SELECT
      c.c_custkey,
      SUM(o.o_totalprice) AS order_total
    FROM
      customer c
      JOIN orders o ON c.c_custkey = o.o_custkey
    GROUP BY
      c.c_custkey
  ),
  customer_order_summary AS (
    SELECT
      co.c_custkey,
      co.o_orderkey,
      co.o_orderdate,
      co.o_totalprice,
      cot.total_orders,
      cot.order_total
    FROM
      customer_orders co
      JOIN customer_total_orders cot ON co.c_custkey = cot.c_custkey
      JOIN customer_order_totals cotl ON co.c_custkey = cotl.c_custkey
  )
SELECT
  c_custkey,
  ARRAY_AGG(o_orderkey) WITHIN GROUP (ORDER BY o_orderdate) AS ordered_orders,
  total_orders,
  order_total
FROM
  customer_order_summary
GROUP BY
  c_custkey,
  total_orders,
  order_total;