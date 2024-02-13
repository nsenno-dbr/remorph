SELECT
  l_orderkey,
  ARRAY_AGG(l_extendedprice ORDER BY l_partkey) WITHIN GROUP (ORDER BY l_quantity) AS aggregated_array
FROM
  lineitem
GROUP BY
  l_orderkey