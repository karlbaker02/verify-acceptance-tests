#!/usr/bin/env bash

set -eu

bundle --quiet
SHOW_BROWSER=true TEST_ENV=local bundle exec cucumber
