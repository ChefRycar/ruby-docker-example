#!/bin/bash

set -eu

export BUILD_START_TIME=`curl -H "Authorization: Bearer $BUILDKITE_API_TOKEN\" \"https://api.buildkite.com/v2/organizations/$BUILDKITE_ORGANIZATION_SLUG/pipelines/$BUILDKITE_PIPELINE_SLUG/builds/$BUILDKITE_BUILD_ID/" | jq -r .started_at`
echo $BUILD_START_TIME
BUILD_START_TIME=`date -d $BUILD_START_TIME +%s`
echo $BUILD_START_TIME

./buildevents build $BUILDKITE_BUILD_ID $BUILD_START_TIME success