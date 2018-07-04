#!/usr/bin/env sh
set -u

docker-compose build
docker-compose run \
               -e TEST_ENV=${TEST_ENV:-"joint"} \
               test-runner -f pretty -f junit -o testreport/ "$@"
exit_status=$?
docker cp $(docker ps -a -q -f name="test-runner"):/testreport .
docker-compose down
exit $exit_status
