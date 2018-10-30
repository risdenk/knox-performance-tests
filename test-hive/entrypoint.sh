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

echo "Creating tbl"
beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice' -n admin -p admin-password -e "CREATE EXTERNAL TABLE IF NOT EXISTS tbl (a string) STORED AS TEXTFILE LOCATION 'hdfs:///tmp/testhive'" >/dev/null 2>/dev/null
beeline -u 'jdbc:hive2://hive-binary:10000/;' -n admin -p admin-password -e "CREATE EXTERNAL TABLE IF NOT EXISTS tbl (a string) STORED AS TEXTFILE LOCATION 'hdfs:///tmp/testhive'" >/dev/null 2>/dev/null

echo
echo "HDFS -text"
echo

command time hdfs dfs -text hdfs:///tmp/testhive/data.txt >/dev/null
command time hdfs dfs -text hdfs:///tmp/testhive/data.txt >/dev/null
command time hdfs dfs -text hdfs:///tmp/testhive/data.txt >/dev/null

echo
echo "Beeline binary default"
echo

command time beeline -u 'jdbc:hive2://hive-binary:10000/' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive-binary:10000/' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive-binary:10000/' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null

echo
echo "Beeline http default"
echo

command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null

echo
echo "Beeline knox http default"
echo

command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null

echo
echo "Beeline binary fetchSize=50000"
echo

command time beeline -u 'jdbc:hive2://hive-binary:10000/;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive-binary:10000/;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive-binary:10000/;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null

echo
echo "Beeline http fetchSize=50000"
echo

command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://hive:10001/;transportMode=http;httpPath=cliservice;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null

echo
echo "Beeline knox http fetchSize=50000"
echo

command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null
command time beeline -u 'jdbc:hive2://knox:8443/;transportMode=http;httpPath=gateway/sandbox/hive;fetchSize=50000' -n admin -p admin-password -e 'select * from tbl limit 200000' > /dev/null

