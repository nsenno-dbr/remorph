SELECT n.n_name, ARRAY_AGG(r.r_name) WITHIN GROUP (ORDER BY r.r_regionkey) AS region_names
FROM nation n
JOIN region r ON n.n_regionkey = r.r_regionkey
GROUP BY n.n_name;