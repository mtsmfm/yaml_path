ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION-alpine

ENV BUNDLE_JOBS=4 \
  BUNDLE_PATH=/vendor/bundle/$RUBY_VERSION

RUN apk update && apk add --no-cache build-base less git ca-certificates openssh-client && update-ca-certificates

RUN gem update bundler

RUN adduser -u 1000 -D app && \
  mkdir -p /app /vendor && \
  chown -R app:app /app /vendor $GEM_HOME $BUNDLE_BIN

USER app
