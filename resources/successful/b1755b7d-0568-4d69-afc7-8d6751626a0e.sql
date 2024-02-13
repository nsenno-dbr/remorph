SELECT
  l_orderkey,
  ARRAY_AGG(l_quantity) WITHIN GROUP (ORDER BY l_discount DESC) AS quantities
FROM
  lineitem
GROUP BY
  l_orderkey