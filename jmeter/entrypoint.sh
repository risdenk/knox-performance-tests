#!/usr/bin/env bash

set -eu

COMPONENT="$1"

rm -rf "/opt/jmeter_testresults/$COMPONENT"
mkdir -p "/opt/jmeter_testresults/$COMPONENT"

/opt/jmeter/bin/jmeter -n -l "/opt/jmeter_testresults/$COMPONENT/testresults.jtl" -e -o "/opt/jmeter_testresults/$COMPONENT/web" -t "/opt/jmeter_testplans/${COMPONENT}.jmx" >/opt/jmeter/run.log 2>&1

cd /opt/ && tar -cOf - jmeter_testresults
