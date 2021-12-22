FROM ubuntu:latest

ENV kubectl_version=v1.16.8

# Install Gcloud.
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    openssh-client \
    vim \
  && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    apt-key add - \
  && echo "deb https://packages.cloud.google.com/apt cloud-sdk main" > \
    /etc/apt/sources.list.d/google-cloud-sdk.list \
  && apt-get update \
  && apt-get install -y \
    google-cloud-sdk

# Install Kubectl.
RUN curl -s https://storage.googleapis.com/kubernetes-release/release/$kubectl_version/bin/linux/amd64/kubectl -o kubectl \
  && mv kubectl /usr/local/bin \
  && chmod +x /usr/local/bin/kubectl

RUN mkdir /app
WORKDIR /app
