SELECT n.n_name, ARRAY_AGG(l.l_extendedprice) WITHIN GROUP (ORDER BY l.l_quantity) AS prices
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
GROUP BY n.n_name;