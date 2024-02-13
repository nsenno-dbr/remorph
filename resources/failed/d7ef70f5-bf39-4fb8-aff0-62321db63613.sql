SELECT
  l.orderkey,
  ARRAY_AGG(l.linenumber ORDER BY l.shipdate) WITHIN GROUP (ORDER BY l.linenumber) AS sorted_linenumbers
FROM
  lineitem l
GROUP BY
  l.orderkey;