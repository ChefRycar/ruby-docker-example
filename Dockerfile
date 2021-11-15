# escape=`
FROM ruby:2.7-alpine

WORKDIR /app
ARG BUILDKITE_PIPELINE_SLUG
ENV BUILDKITE_PIPELINE_SLUG ${BUILDKITE_PIPELINE_SLUG}
ARG BUILDKITE_BUILD_NUMBER
ENV BUILDKITE_BUILD_NUMBER ${BUILDKITE_BUILD_NUMBER}

ADD Gemfile Gemfile.lock /app/
ADD https://github.com/honeycombio/buildevents/releases/latest/download/buildevents-linux-amd64 buildevents
RUN chmod 755 buildevents

RUN apk update && apk add bash
RUN env
RUN ./buildevents cmd $BUILDKITE_PIPELINE_SLUG-$BUILDKITE_BUILD_NUMBER $(echo rspec-test | sum | cut -f 1 -d \ ) bundle-install -- bundle install -j 8

ADD . /app
