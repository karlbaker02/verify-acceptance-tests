#!/usr/bin/env sh
set -u

# Make sure that we tear down first due to tools deploy getting these
# containers into an unrecoverable state if we don't explicitly do this
docker-compose down
docker-compose build
docker-compose run \
               -e TEST_ENV=${TEST_ENV:-"joint"} \
               test-runner -f pretty -f junit -o testreport/ --fail-fast "$@"
exit_status=$?
docker cp $(docker ps -a -q -f name="test-runner"):/testreport .
docker-compose down
exit $exit_status
