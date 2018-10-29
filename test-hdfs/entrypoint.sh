#!/usr/bin/env bash

set -eu

export HADOOP_HOME=/opt/hadoop
export PATH=$HADOOP_HOME/bin:$PATH

cd $HADOOP_HOME

echo "Generating 1GB file"
dd if=/dev/zero of=/tmp/1GB.txt count=1024 bs=1048576 >/dev/null 2>/dev/null
echo "Upload 1GB file to HDFS"
hdfs dfs -copyFromLocal -f /tmp/1GB.txt hdfs:///tmp/

command time hdfs dfs -text hdfs:///tmp/1GB.txt >/dev/null
command time hdfs dfs -text hdfs:///tmp/1GB.txt >/dev/null
command time hdfs dfs -text hdfs:///tmp/1GB.txt >/dev/null

command time curl -s -u admin:admin-password -L --location-trusted "http://hdfs:9870/webhdfs/v1/tmp/1GB.txt?op=OPEN"
command time curl -s -u admin:admin-password -L --location-trusted "http://hdfs:9870/webhdfs/v1/tmp/1GB.txt?op=OPEN"
command time curl -s -u admin:admin-password -L --location-trusted "http://hdfs:9870/webhdfs/v1/tmp/1GB.txt?op=OPEN"

command time curl -s -u admin:admin-password -L --location-trusted "http://knox:8443/gateway/sandbox/webhdfs/v1/tmp/1GB.txt?op=OPEN"
command time curl -s -u admin:admin-password -L --location-trusted "http://knox:8443/gateway/sandbox/webhdfs/v1/tmp/1GB.txt?op=OPEN"
command time curl -s -u admin:admin-password -L --location-trusted "http://knox:8443/gateway/sandbox/webhdfs/v1/tmp/1GB.txt?op=OPEN"

