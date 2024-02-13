SELECT
  n_name,
  ARRAY_AGG(o_orderdate WITHIN GROUP (ORDER BY o_totalprice DESC)) AS order_dates
FROM
  nation
JOIN
  customer ON n_nationkey = c_nationkey
JOIN
  orders ON c_custkey = o_custkey
GROUP BY
  n_name