#!/usr/bin/env bash

rm -rf jmeter_testresults
docker-compose run --rm -T jmeter-hdfs | tar -xf -
