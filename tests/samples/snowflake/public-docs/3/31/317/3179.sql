CREATE EXTERNAL TABLE et1(
 date_part date AS TO_DATE(SPLIT_PART(metadata$filename, '/', 3)
   || '/' || SPLIT_PART(metadata$filename, '/', 4)
   || '/' || SPLIT_PART(metadata$filename, '/', 5), 'YYYY/MM/DD'),
 timestamp bigint AS (value:timestamp::bigint),
 col2 varchar AS (value:col2::varchar))
 PARTITION BY (date_part)
 LOCATION=@s1/logs/
 AUTO_REFRESH = true
 FILE_FORMAT = (TYPE = PARQUET)
 AWS_SNS_TOPIC = 'arn:aws:sns:us-west-2:001234567890:s3_mybucket';