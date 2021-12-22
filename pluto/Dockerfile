FROM ubuntu:latest

ENV pluto_version=3.0.1

# Install Pluto.
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    wget \
  && wget -nv "https://github.com/FairwindsOps/pluto/releases/download/v${pluto_version}/pluto_${pluto_version}_checksums.txt" \
  && wget -nv "https://github.com/FairwindsOps/pluto/releases/download/v${pluto_version}/pluto_${pluto_version}_linux_amd64.tar.gz" \
  && echo "$(grep linux_amd64 pluto_${pluto_version}_checksums.txt | awk '{print $1}')" pluto_${pluto_version}_linux_amd64.tar.gz | \
       sha256sum -c --status \
  && tar -xzvf pluto_${pluto_version}_linux_amd64.tar.gz \
  && chmod u+x pluto \
  && cp pluto /usr/local/bin/pluto

RUN mkdir /app
WORKDIR /app
