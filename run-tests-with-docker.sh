#!/usr/bin/env sh
set -eu

trap "docker-compose down" EXIT

docker-compose build verify-acceptance-tests
docker-compose run \
               -e TEST_ENV=${TEST_ENV:-"joint"} \
               verify-acceptance-tests $@
