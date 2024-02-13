SELECT n_name, ARRAY_AGG(o_totalprice) WITHIN GROUP (ORDER BY o_orderdate DESC) AS total_prices
FROM nation
JOIN region ON n_regionkey = r_regionkey
JOIN customer ON c_nationkey = n_nationkey
JOIN orders ON o_custkey = c_custkey
GROUP BY n_name;