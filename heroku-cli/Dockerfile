FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  nodejs

RUN mkdir /app
WORKDIR /app

RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
RUN heroku plugins:install heroku-kafka
