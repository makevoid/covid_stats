FROM ruby:2.7.2-alpine3.12

RUN apk --no-cache add make gcc libc-dev curl \
    rm -rf /var/cache/apk/*

WORKDIR /app

ADD Gemfile* ./
RUN bundle install

ADD . /app

CMD rake
