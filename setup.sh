#!/usr/bin/env bash

set -eu

docker-compose down -v --remove-orphans
docker-compose build --pull
docker-compose up -d --force-recreate --renew-anon-volumes --remove-orphans knox hdfs hbase hive hive-binary
