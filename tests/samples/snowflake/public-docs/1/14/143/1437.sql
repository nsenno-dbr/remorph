select *
  from table(information_schema.materialized_view_refresh_history(
    date_range_start=>'2019-05-22 19:00:00.000',
    date_range_end=>'2019-05-22 20:00:00.000'));