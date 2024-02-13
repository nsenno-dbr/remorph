SELECT
  n.name,
  ARRAY_AGG(l.quantity ORDER BY l.extendedprice DESC) WITHIN GROUP (ORDER BY l.shipdate) AS quantities
FROM
  lineitem l
  JOIN orders o ON l.orderkey = o.orderkey
  JOIN customer c ON o.custkey = c.custkey
  JOIN nation n ON c.nationkey = n.nationkey
GROUP BY
  n.name;