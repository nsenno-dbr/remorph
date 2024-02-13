SELECT
  n.n_name,
  ARRAY_AGG(c.c_name) WITHIN GROUP (ORDER BY c.c_acctbal DESC) AS customer_names
FROM
  customer c
JOIN
  nation n ON c.c_nationkey = n.n_nationkey
GROUP BY
  n.n_name;