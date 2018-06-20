#!/usr/bin/env sh
set -eu

teardown() {
    docker-compose down
}

trap teardown EXIT

mkdir -p testreport
docker-compose build verify-acceptance-tests
docker-compose run \
               -u $(id -u):$(id -g) \
               -e TEST_ENV=${TEST_ENV:-"joint"} \
               verify-acceptance-tests -f pretty -f junit -o testreport/ $@
