SELECT
  n.n_name,
  ARRAY_AGG(s.s_name) WITHIN GROUP (ORDER BY s.s_acctbal DESC) AS sorted_names
FROM
  nation n
JOIN
  supplier s ON n.n_nationkey = s.s_nationkey
GROUP BY
  n.n_name