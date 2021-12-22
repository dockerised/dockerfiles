FROM ubuntu:latest

# Staging and Prod Envs are currently on 0.12.20.
ENV terraform_version=0.12.20
# PR Env is currently on 0.12.26.
# ENV terraform_version=0.12.26

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    git \
    unzip \
    wget \
  && wget -nv "https://releases.hashicorp.com/terraform/$terraform_version/terraform_${terraform_version}_linux_amd64.zip" \
  && unzip "terraform_${terraform_version}_linux_amd64.zip" \
  && cp terraform /usr/local/bin

RUN mkdir /app
WORKDIR /app
