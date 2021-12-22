FROM centos:7

ENV kafka_version=2.2.1

# Update and install some useful packages.
RUN yum update -y && \
  yum install -y java-1.8.0-openjdk \
    wget

# Install Kafka.
#
# https://www.apache.org/dyn/closer.cgi?path=/kafka/$kafka_version/kafka_2.12-$kafka_version.tgz
#
# The above link takes you to a list of mirrors.  Probably best to programmatically choose one, but
# that would add a lot of complexity.  I chose Berkeley, because I have a reasonable expectation
# of being able to trust a university.  Regardless, we check GPG and SHA after downloading anyway.
#
# The sha512sum is in a strange format, so I had to do some manipulation on it to get the check to
# run properly.
RUN wget -nv http://mirrors.ocf.berkeley.edu/apache/kafka/2.2.1/kafka_2.12-2.2.1.tgz \
  && wget -nv https://www.apache.org/dist/kafka/$kafka_version/kafka_2.12-$kafka_version.tgz.sha512 \
  && tr -d '\040\011\012\015' < kafka_2.12-$kafka_version.tgz.sha512 | \
     sed -E 's/(.*\.tgz):(.*)/\2  \1/' | \
     tr '[:upper:]' '[:lower:]' | \
     sed -E 's/(.*)/\1\n/' > kafka.sha512 \
  && sha512sum -c kafka.sha512 < kafka_2.12-$kafka_version.tgz \
  && wget -nv https://www.apache.org/dist/kafka/$kafka_version/kafka_2.12-$kafka_version.tgz.asc \
  && wget -nv https://www.apache.org/dist/kafka/KEYS \
  && gpg --import KEYS \
  && gpg --verify kafka_2.12-$kafka_version.tgz.asc kafka_2.12-$kafka_version.tgz \
  && tar -xzvf kafka_2.12-$kafka_version.tgz

RUN mkdir /app
WORKDIR /app
