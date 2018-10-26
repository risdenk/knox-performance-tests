#!/usr/bin/env bash

set -eu

COMPONENT="$1"

rm -rf "/opt/jmeter_testresults/$COMPONENT"
mkdir -p "/opt/jmeter_testresults/$COMPONENT"

exec /opt/jmeter/bin/jmeter -n -l "/opt/jmeter_testresults/$COMPONENT/testresults.jtl" -e -o "/opt/jmeter_testresults/$COMPONENT/web" -t "/opt/jmeter_testplans/${COMPONENT}.jmx"

