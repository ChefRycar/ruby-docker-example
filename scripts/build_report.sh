#!/bin/bash

set -eu

./buildevents build $BUILDKITE_PIPELINE_SLUG-$BUILDKITE_BUILD_NUMBER $BUILD_START_TIME success