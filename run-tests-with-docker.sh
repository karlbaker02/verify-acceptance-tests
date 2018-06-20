#!/usr/bin/env sh
set -eu

teardown() {
    docker-compose down
}

trap teardown EXIT

docker-compose build
docker-compose run \
               -e TEST_ENV=${TEST_ENV:-"joint"} \
               test-runner -f pretty -f junit -o testreport/ $@
docker cp $(docker ps -a -q -f name="test-runner"):/testreport .
