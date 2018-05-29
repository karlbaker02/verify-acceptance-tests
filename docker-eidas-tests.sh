#!/usr/bin/env sh
set -eu

docker-compose up -d selenium-hub
docker-compose build verify-acceptance-tester
docker-compose run \
               -e TEST_ENV=joint \
               -v $PWD/features:/features:ro \
               verify-acceptance-tester \
               features/eidas_user_journeys.feature
docker-compose down

