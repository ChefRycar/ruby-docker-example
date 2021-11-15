FROM ruby:2.7-alpine

WORKDIR /app
ARG BUILDKITE_BUILD_ID
ARG BUILDKITE_STEP_ID

ADD Gemfile Gemfile.lock /app/
ADD https://github.com/honeycombio/buildevents/releases/latest/download/buildevents-linux-amd64 buildevents
RUN chmod 755 buildevents

RUN apk update && apk add bash
RUN echo "Build ID: $BUILDKITE_BUILD_ID\n"
RUN echo "Step ID: $BUILDKITE_STEP_ID\n"
RUN env
RUN ./buildevents cmd $BUILDKITE_BUILD_ID $BUILDKITE_STEP_ID bundle-install -- bundle install -j 8

ADD . /app
