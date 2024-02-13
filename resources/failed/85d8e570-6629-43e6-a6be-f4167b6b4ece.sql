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
  l_orderkey,
  quantities
FROM
  lineitem_agg