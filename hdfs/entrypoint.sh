#!/usr/bin/env bash

set -eu
set -x

rm -f /tmp/*.pid

/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start namenode
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start secondarynamenode
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start datanode

/opt/hadoop/bin/hdfs dfs -mkdir -p /tmp
/opt/hadoop/bin/hdfs dfs -chmod g+w /tmp
/opt/hadoop/bin/hdfs dfs -chmod 1777 /tmp/

/opt/hadoop/bin/hdfs dfs -mkdir -p /user/hive/warehouse
/opt/hadoop/bin/hdfs dfs -chmod g+w /user/hive/warehouse

tail -f /opt/hadoop/logs/*

