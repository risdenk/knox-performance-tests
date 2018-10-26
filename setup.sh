#!/usr/bin/env bash

set -eu

docker-compose build --pull
docker-compose up -d --force-recreate knox hdfs hbase hive
