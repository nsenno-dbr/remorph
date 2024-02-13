SELECT
  l_orderkey,
  ARRAY_AGG(l_partkey ORDER BY l_shipdate) AS partkeys
FROM
  lineitem
GROUP BY
  l_orderkey;