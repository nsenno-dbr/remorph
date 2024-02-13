SELECT
  l_orderkey,
  ARRAY_AGG(l_partkey) WITHIN GROUP (ORDER BY l_quantity DESC) AS sorted_partkeys
FROM
  lineitem
GROUP BY
  l_orderkey;