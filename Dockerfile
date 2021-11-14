FROM ruby:2.7-alpine

WORKDIR /app

ADD Gemfile Gemfile.lock /app/

ADD https://github.com/honeycombio/buildevents/releases/latest/download/buildevents-linux-amd64 buildevents
RUN chmod 755 buildevents
ENV STEP_START=$(date +%s)
ENV STEP_SPAN_ID=$(echo bundle | sum | cut -f 1 -d \ )
RUN ./buildevents cmd $BUILDKITE_BUILD_ID $STEP_SPAN_ID bundle-install -- bundle install -j 8

ADD . /app
