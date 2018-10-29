#!/usr/bin/env bash

#rm -rf jmeter_testresults
docker-compose run --rm -T jmeter-hdfs | tar -xf -
docker-compose run --rm -T jmeter-hbase | tar -xf -
#docker-compose run --rm -T jmeter-hive | tar -xf -

#docker-compose run --rm test-hdfs
#docker-compose run --rm test-hbase
#docker-compose run --rm test-hive
