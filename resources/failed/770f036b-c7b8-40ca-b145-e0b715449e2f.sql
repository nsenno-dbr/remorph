SELECT
  l_orderkey,
  ARRAY_AGG(l_quantity ORDER BY l_shipdate) WITHIN GROUP (ORDER BY l_partkey DESC) AS quantities
FROM
  lineitem
GROUP BY
  l_orderkey;