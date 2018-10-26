#!/usr/bin/env bash

set -eu
set -x

sleep 5

/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start namenode
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start secondarynamenode
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start datanode

sleep 3

tail -f /opt/hadoop/logs/*

