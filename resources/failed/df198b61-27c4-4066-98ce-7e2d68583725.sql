WITH customer_revenue AS (
    SELECT c.c_custkey,
           c.c_name,
           SUM(o.o_totalprice) AS total_revenue
    FROM customer c
    JOIN orders o ON c.c_custkey = o.o_custkey
    GROUP BY c.c_custkey, c.c_name
)
SELECT c.c_name,
       ARRAY_AGG(o.o_orderkey ORDER BY o.o_orderdate) AS ordered_order_keys
FROM customer_revenue cr
JOIN orders o ON cr.c_custkey = o.o_custkey
JOIN customer c ON cr.c_custkey = c.c_custkey
GROUP BY c.c_name;