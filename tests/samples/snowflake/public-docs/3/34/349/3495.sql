SELECT * 
    FROM departments AS d, LATERAL (SELECT * FROM employees AS e WHERE e.department_ID = d.department_ID) AS iv2
    ORDER BY employee_ID;