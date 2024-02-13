SELECT
  n_name,
  ARRAY_AGG(o_orderdate) WITHIN GROUP (ORDER BY o_totalprice DESC) AS order_dates
FROM
  customer,
  orders,
  nation
WHERE
  c_custkey = o_custkey
  AND c_nationkey = n_nationkey
GROUP BY
  n_name;