WITH
  orders_agg AS (
    SELECT
      o.orderkey,
      ARRAY_AGG(o.orderdate) WITHIN GROUP (ORDER BY o.shippriority DESC) AS orderdates
    FROM
      orders o
    GROUP BY
      o.orderkey
  )
SELECT
  oa.orderkey,
  oa.orderdates
FROM
  orders_agg oa
ORDER BY
  oa.orderkey;