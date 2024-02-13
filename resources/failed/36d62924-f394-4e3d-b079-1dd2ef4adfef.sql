SELECT
  l_orderkey,
  ARRAY_AGG(l_quantity ORDER BY l_partkey) WITHIN GROUP (ORDER BY l_shipdate DESC) AS aggregated_array
FROM
  lineitem
GROUP BY
  l_orderkey;