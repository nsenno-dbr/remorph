WITH
  lineitem_agg AS (
    SELECT
      l_orderkey,
      ARRAY_AGG(l_quantity ORDER BY l_shipdate) AS quantities
    FROM
      lineitem
    GROUP BY
      l_orderkey
  )
SELECT
  o_orderkey,
  quantities
FROM
  orders
JOIN
  lineitem_agg ON o_orderkey = l_orderkey
LIMIT
  10;