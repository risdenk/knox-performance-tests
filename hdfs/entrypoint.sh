#!/usr/bin/env bash

set -eu
set -x

rm -f /tmp/*.pid

/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start namenode
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start secondarynamenode
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start datanode

tail -f /opt/hadoop/logs/*

