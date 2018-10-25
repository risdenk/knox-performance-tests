#!/usr/bin/env bash

set -eu

docker-compose pull
docker-compose up -d --force-recreate --build
