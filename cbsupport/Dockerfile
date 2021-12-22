FROM debian:latest

ENV kubectl_version=v1.16.13

# Install Gcloud.
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    bash-completion \
    ca-certificates \
    curl \
    gnupg2 \
    openssh-client \
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

# Install cbsupport.
RUN curl -sLO https://s3.amazonaws.com/cbsupport-binaries/stable/cbsupport-linux-amd64 \
  && curl -sLO https://s3.amazonaws.com/cbsupport-binaries/stable/cbsupport-linux-amd64.sha256 \
  && sha256sum -c cbsupport-linux-amd64.sha256 \
  && cp cbsupport-linux-amd64 /usr/local/bin/cbsupport \
  && chmod +x /usr/local/bin/cbsupport

RUN mkdir /app
WORKDIR /app
