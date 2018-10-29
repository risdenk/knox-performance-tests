#!/usr/bin/env bash

set -eu

export HBASE_HOME=/opt/hbase
export PATH=$HBASE_HOME/bin:$PATH

cd $HBASE_HOME

python /generate_data.py 1000000 >/tmp/testdata.json

curl -s -X DELETE -H "Accept: text/xml" "http://hbase:8080/testdata/schema"
curl -s -XPUT -H "Accept: text/xml" -H "Content-Type: text/xml" -d '<?xml version="1.0" encoding="UTF-8"?><TableSchema name="testdata"><ColumnSchema name="a" /></TableSchema>' "http://hbase:8080/testdata/schema"
curl -s -XPUT -H "Accept: application/json" -H "Content-Type: application/json" -d@/tmp/testdata.json "http://hbase:8080/testdata/fakerow"

command time curl -u admin:admin-password -s -H "Accept: application/json" 'http://hbase:8080/testdata/*?limit=400000' >/dev/null
command time curl -u admin:admin-password -s -H "Accept: application/json" 'http://hbase:8080/testdata/*?limit=400000' >/dev/null
command time curl -u admin:admin-password -s -H "Accept: application/json" 'http://hbase:8080/testdata/*?limit=400000' >/dev/null

command time curl -u admin:admin-password -s -H "Accept: application/json" 'http://knox:8443/gateway/sandbox/hbase/testdata/*?limit=400000' >/dev/null
command time curl -u admin:admin-password -s -H "Accept: application/json" 'http://knox:8443/gateway/sandbox/hbase/testdata/*?limit=400000' >/dev/null
command time curl -u admin:admin-password -s -H "Accept: application/json" 'http://knox:8443/gateway/sandbox/hbase/testdata/*?limit=400000' >/dev/null

