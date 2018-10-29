#!/usr/bin/env bash

set -eu

export HADOOP_HOME=/opt/hadoop
export HIVE_HOME=/opt/hive
export PATH=$HIVE_HOME/bin:$HADOOP_HOME/bin:$PATH

cd $HIVE_HOME

echo "Generating ~1GB file"
export RANDSTR=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 1000 | head -n 1); for x in $(seq 1 1000000); do echo $RANDSTR >> /tmp/data.txt; done
echo "Upload ~1GB file to HDFS"
hdfs dfs -mkdir -p /tmp/testhive
hdfs dfs -copyFromLocal -f /tmp/data.txt hdfs:///tmp/testhive/

beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice' -n admin -p admin-password -e "CREATE EXTERNAL TABLE IF NOT EXISTS tbl (a string) STORED AS TEXTFILE LOCATION 'hdfs:///tmp/testhive'" > /dev/null

command time hdfs dfs -text hdfs:///tmp/testhive/data.txt >/dev/null
command time hdfs dfs -text hdfs:///tmp/testhive/data.txt >/dev/null
command time hdfs dfs -text hdfs:///tmp/testhive/data.txt >/dev/null

command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null

command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null

