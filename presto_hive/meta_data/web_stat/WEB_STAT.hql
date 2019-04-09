CREATE EXTERNAL TABLE WEB_STAT (
     HOST STRING,
     DOMAIN STRING,
     FEATURE STRING,
     `DATE` TIMESTAMP,
     USAGE__CORE BIGINT,
     USAGE__DB BIGINT,
     STATS__ACTIVE_VISITOR INTEGER
)
COMMENT 'from csv file'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\054'
STORED AS TEXTFILE
LOCATION '/root/data/web_stat'
;
SELECT * FROM web_stat LIMIT 5;