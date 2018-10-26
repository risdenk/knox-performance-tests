#!/usr/bin/env bash

set -eu

/opt/knox/bin/gateway.sh start

tail -f /opt/knox/logs/*
