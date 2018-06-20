#!/usr/bin/env sh
set -eu

teardown() {
    docker-compose down
}

trap teardown EXIT

docker-compose build verify-acceptance-tests
docker-compose run \
               -e TEST_ENV=${TEST_ENV:-"joint"} \
               verify-acceptance-tests -f pretty -f junit -o testreport/ $@
