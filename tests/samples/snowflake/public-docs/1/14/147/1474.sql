SELECT *
  FROM TABLE(information_schema.stage_directory_file_registration_history(
    START_TIME=>DATEADD('hour',-1,current_timestamp()),
    STAGE_NAME=>'mydb.public.mystage'));