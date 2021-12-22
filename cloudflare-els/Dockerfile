FROM ubuntu:16.04

RUN apt-get update && apt-get -y install software-properties-common 
RUN apt-get update && apt-get -y install build-essential
RUN apt-get update && apt-get -y install curl
RUN apt-get update && apt-get -y install vim
RUN apt-get update && apt-get -y install jq

RUN mkdir /app

RUN curl -L -o /app/logshare-cli https://github.com/cloudflare/logshare/releases/download/v1.4.2/logshare.linux.amd64

RUN chmod 755 /app/logshare-cli

WORKDIR /app


