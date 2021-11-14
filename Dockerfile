FROM ruby:2.7-alpine

WORKDIR /app

ADD Gemfile Gemfile.lock /app/

RUN curl -L -o buildevents https://github.com/honeycombio/buildevents/releases/latest/download/buildevents-linux-amd64 && chmod 755 buildevents
RUN STEP_START=$(date +%s)
RUN STEP_SPAN_ID=$(echo bundle | sum | cut -f 1 -d \ )
./buildevents cmd $BUILDKITE_BUILD_ID $STEP_SPAN_ID bundle-install -- RUN bundle install -j 8

ADD . /app
