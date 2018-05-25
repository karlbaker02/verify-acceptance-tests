#!/usr/bin/env bash

set -eu

RUN_XVFB="${RUN_XVFB:-false}"

test "$RUN_XVFB" = "true" && Xvfb $DISPLAY -ac >/dev/null &

bundle --quiet
bundle exec cucumber
