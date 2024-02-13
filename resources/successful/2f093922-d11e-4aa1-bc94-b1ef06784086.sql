SELECT c_custkey, ARRAY_AGG(c_name) WITHIN GROUP (ORDER BY c_nationkey) AS customer_names
FROM customer
GROUP BY c_custkey;