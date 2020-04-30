FROM ruby:2.7.0-alpine as builder

RUN apk add \
build-base \
curl \
ca-certificates \
gnupg1 \
libffi-dev \
graphicsmagick \
libsodium-dev \
python \
make \
nodejs=12.15.0-r1 \
postgresql-dev \
tzdata \
yarn

WORKDIR /app
COPY Gemfile Gemfile.lock /app/

RUN bundle config --global frozen 1 \
&& bundle install --without development test -j4 --retry 3 \
&& rm -rf /usr/local/bundle/cache/*.gem \
&& find /usr/local/bundle/gems/ -name "*.c" -delete \
&& find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . /app/
RUN SECRET_KEY_BASE='dummy' RAILS_ENV='production' rails assets:precompile
RUN rm -rf node_modules tmp/* log/*

FROM ruby:2.7.0-alpine

RUN apk add --update --no-cache \
postgresql-dev \
graphicsmagick \
tzdata \
nodejs \
file

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app/ /app/

WORKDIR /app

EXPOSE 3000
