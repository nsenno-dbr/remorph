SELECT
  s.name,
  ARRAY_AGG(l.l_quantity ORDER BY l.l_shipdate) WITHIN GROUP (ORDER BY l.l_quantity DESC) AS sorted_quantities
FROM
  supplier s
JOIN
  lineitem l ON s.s_suppkey = l.l_suppkey
GROUP BY
  s.name;