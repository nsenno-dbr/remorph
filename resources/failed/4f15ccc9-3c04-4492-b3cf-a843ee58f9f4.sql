SELECT
  l.orderkey,
  ARRAY_AGG(l.linenumber ORDER BY l.quantity DESC) WITHIN GROUP (ORDER BY l.partkey) AS sorted_linenumbers
FROM
  lineitem l
GROUP BY
  l.orderkey;