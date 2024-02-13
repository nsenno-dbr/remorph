SELECT
  l_orderkey,
  ARRAY_AGG(l_quantity) WITHIN GROUP (ORDER BY l_partkey DESC) AS aggregated_array
FROM
  lineitem
GROUP BY
  l_orderkey;