WITH
  customer_revenue AS (
    SELECT
      c_custkey,
      c_name,
      SUM(o_totalprice) AS total_revenue
    FROM
      customer,
      orders
    WHERE
      c_custkey = o_custkey
    GROUP BY
      c_custkey,
      c_name
  ),
  customer_orders AS (
    SELECT
      c_custkey,
      c_name,
      ARRAY_AGG(o_orderkey ORDER BY o_orderdate) AS order_keys
    FROM
      customer,
      orders
    WHERE
      c_custkey = o_custkey
    GROUP BY
      c_custkey,
      c_name
  )
SELECT
  cr.c_custkey,
  cr.c_name,
  cr.total_revenue,
  co.order_keys
FROM
  customer_revenue cr
JOIN
  customer_orders co ON cr.c_custkey = co.c_custkey
ORDER BY
  cr.total_revenue DESC;