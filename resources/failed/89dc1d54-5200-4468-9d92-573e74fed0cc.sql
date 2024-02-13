SELECT
  o.orderkey,
  ARRAY_AGG(l.linenumber) WITHIN GROUP (ORDER BY l.quantity DESC) AS line_numbers
FROM
  orders o
JOIN
  lineitem l ON o.orderkey = l.orderkey
WHERE
  o.orderdate >= '1994-01-01' AND o.orderdate < '1995-01-01'
GROUP BY
  o.orderkey;