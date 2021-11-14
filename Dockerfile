FROM ruby:2.7-alpine

WORKDIR /app

ADD Gemfile Gemfile.lock /app/

ADD https://github.com/honeycombio/buildevents/releases/latest/download/buildevents-linux-amd64 buildevents
RUN chmod 755 buildevents
RUN bundle install -j 8

ADD . /app
