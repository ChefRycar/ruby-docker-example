FROM ruby:2.7-alpine

WORKDIR /app
ARG BUILDKITE_BUILD_ID
ENV BUILDKITE_BUILD_ID ${BUILDKITE_BUILD_ID}

ADD Gemfile Gemfile.lock /app/
ADD https://github.com/honeycombio/buildevents/releases/latest/download/buildevents-linux-amd64 buildevents
RUN chmod 755 buildevents

RUN apk update && apk add bash
RUN echo $BUILDKITE_BUILD_ID
RUN export STEP_SPAN_ID=$(echo rspec-test | sum | cut -f 1 -d \ )
RUN echo $STEP_SPAN_ID
RUN env
RUN ./buildevents cmd $BUILDKITE_BUILD_ID $STEP_SPAN_ID bundle-install -- bundle install -j 8

ADD . /app
