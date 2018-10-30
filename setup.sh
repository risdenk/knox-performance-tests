#!/usr/bin/env bash

set -eu

docker-compose build --pull
docker-compose up -d --force-recreate --renew-anon-volumes knox hdfs hbase hive hive-binary
