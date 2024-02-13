SELECT
  l_orderkey,
  ARRAY_AGG(l_quantity ORDER BY l_partkey) WITHIN GROUP (ORDER BY l_partkey) AS quantities
FROM
  lineitem
GROUP BY
  l_orderkey;