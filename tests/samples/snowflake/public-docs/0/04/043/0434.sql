select time_from_parts(0, 100, 0), time_from_parts(12, 0, 12345);

----------------------------+-------------------------------+
 TIME_FROM_PARTS(0, 100, 0) | TIME_FROM_PARTS(12, 0, 12345) |
----------------------------+-------------------------------+
 01:40:00.000000000         | 15:25:45.000000000            |
----------------------------+-------------------------------+