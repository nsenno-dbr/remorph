WITH
  sorted_lineitems AS (
    SELECT
      l_orderkey,
      ARRAY_AGG(l_linenumber ORDER BY l_shipdate) AS sorted_linenumbers
    FROM
      lineitem
    GROUP BY
      l_orderkey
  )
SELECT
  l_orderkey,
  sorted_linenumbers
FROM
  sorted_lineitems