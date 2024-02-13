WITH
  lineitem_agg AS (
    SELECT
      orderkey,
      ARRAY_AGG(linenumber ORDER BY shipdate) AS linenumber_array
    FROM
      lineitem
    GROUP BY
      orderkey
  )
SELECT
  orderkey,
  linenumber_array
FROM
  lineitem_agg