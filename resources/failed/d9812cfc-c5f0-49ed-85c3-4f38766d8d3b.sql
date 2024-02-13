SELECT
  l_orderkey,
  ARRAY_AGG(l_partkey ORDER BY l_quantity DESC) WITHIN GROUP (ORDER BY l_shipdate) AS sorted_parts
FROM
  lineitem
GROUP BY
  l_orderkey