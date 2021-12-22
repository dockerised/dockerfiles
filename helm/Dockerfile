FROM ubuntu:latest

ENV helm_version=v2.14.3 \
    kubectl_version=v1.16.8 \
    reckoner_version=v3.2.1

# Install Gcloud.
RUN apt-get update && apt-get install -y \
    apt-transport-https \
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

# Install Helm.
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    wget \
  && wget -nv "https://get.helm.sh/helm-$helm_version-linux-amd64.tar.gz" \
  && wget -nv "https://get.helm.sh/helm-$helm_version-linux-amd64.tar.gz.sha256" \
  && echo "$(cat helm-$helm_version-linux-amd64.tar.gz.sha256) helm-$helm_version-linux-amd64.tar.gz" | \
       sha256sum -c --status \
  && tar -xzvf helm-$helm_version-linux-amd64.tar.gz \
  && cp linux-amd64/helm /usr/local/bin

# Install Reckoner.
RUN apt-get update && apt-get install -y \
    git \
    python3 \
  && wget -nv "https://github.com/FairwindsOps/reckoner/releases/download/$reckoner_version/reckoner-linux-amd64" \
  && chmod u+x reckoner-linux-amd64 \
  && cp reckoner-linux-amd64 /usr/local/bin/reckoner

RUN mkdir /app
WORKDIR /app
