SELECT pi() * AS_DOUBLE(v_radius) * AS_DOUBLE(v_radius) AS area1, 
       pi() * radius * radius AS area2        
  FROM demo;