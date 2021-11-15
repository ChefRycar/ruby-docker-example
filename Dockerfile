FROM ruby:2.7-alpine

WORKDIR /app
ARG BUILDKITE_BUILD_ID
ENV BUILDKITE_BUILD_ID ${BUILDKITE_BUILD_ID}
ARG BUILDKITE_STEP_ID
ENV BUILDKITE_STEP_ID ${BUILDKITE_STEP_ID}

ADD Gemfile Gemfile.lock /app/
ADD https://github.com/honeycombio/buildevents/releases/latest/download/buildevents-linux-amd64 buildevents
RUN chmod 755 buildevents

RUN apk update && apk add bash
RUN echo $BUILDKITE_BUILD_ID
RUN echo $BUILDKITE_STEP_ID
RUN env
RUN ./buildevents cmd $BUILDKITE_BUILD_ID $BUILDKITE_STEP_ID bundle-install -- bundle install -j 8

ADD . /app
