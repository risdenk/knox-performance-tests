#!/usr/bin/env bash

set -eu

/opt/knox/bin/ldap.sh start

tail -f /opt/knox/logs/*
