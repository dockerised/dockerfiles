FROM alpine:3.6

# Versions: https://pypi.python.org/pypi/awscli#downloads
ENV AWS_CLI_VERSION 1.11.131

RUN apk --no-cache update && \
    apk --no-cache add bash bash-doc bash-completion python py-pip py-setuptools ca-certificates groff less && \
    pip --no-cache-dir install awscli==${AWS_CLI_VERSION} && \
    rm -rf /var/cache/apk/*

RUN echo "complete -C /usr/bin/aws_completer aws" > /root/.bashrc

WORKDIR /root
