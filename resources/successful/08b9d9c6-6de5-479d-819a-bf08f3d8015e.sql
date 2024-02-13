SELECT n.n_name, ARRAY_AGG(l.l_extendedprice) WITHIN GROUP (ORDER BY l.l_quantity) AS prices
FROM nation n
JOIN supplier s ON n.n_nationkey = s.s_nationkey
JOIN lineitem l ON s.s_suppkey = l.l_suppkey
GROUP BY n.n_name;