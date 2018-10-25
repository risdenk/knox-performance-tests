#!/usr/bin/env bash

set -eu

/opt/knox/bin/ldap.sh start
/opt/knox/bin/gateway.sh start

tail -f /opt/knox/logs/*
