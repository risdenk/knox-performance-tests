#!/usr/bin/env bash

set -eu
set -x

rm -f /tmp/*.pid

kadmin --principal=admin --keytab=/etc/docker-etc/admin.keytab add --use-defaults --random-password nn/$(hostname -f)
kadmin --principal=admin --keytab=/etc/docker-etc/admin.keytab ext_keytab -k /opt/hadoop/nn.service.keytab hdfs/$(hostname -f)

kadmin --principal=admin --keytab=/etc/docker-etc/admin.keytab add --use-defaults --random-password sn/$(hostname -f)
kadmin --principal=admin --keytab=/etc/docker-etc/admin.keytab ext_keytab -k /opt/hadoop/sn.service.keytab hdfs/$(hostname -f)

kadmin --principal=admin --keytab=/etc/docker-etc/admin.keytab add --use-defaults --random-password dn/$(hostname -f)
kadmin --principal=admin --keytab=/etc/docker-etc/admin.keytab ext_keytab -k /opt/hadoop/dn.service.keytab hdfs/$(hostname -f)

/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start namenode
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start secondarynamenode
/opt/hadoop/bin/hdfs --config /opt/hadoop/etc/hadoop/ --daemon start datanode

/opt/hadoop/bin/hdfs dfs -mkdir -p /tmp
/opt/hadoop/bin/hdfs dfs -chmod g+w /tmp
/opt/hadoop/bin/hdfs dfs -chmod 1777 /tmp/

/opt/hadoop/bin/hdfs dfs -mkdir -p /user/hive/warehouse
/opt/hadoop/bin/hdfs dfs -chmod g+w /user/hive/warehouse

tail -f /opt/hadoop/logs/*

