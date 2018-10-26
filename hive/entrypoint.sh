#!/usr/bin/env bash

set -eu

/opt/hive/bin/schematool -dbType derby -initSchema
/opt/hive/bin/hiveserver2 --hiveconf hive.server2.enable.doAs=false "$@"

