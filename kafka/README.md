# kafka

Run Kafka client in a docker container.

## Setup Docker

* Build the container image.

```
docker build [--no-cache] -t kafka .
```

* Create docker volume to store Kafka Java keystore and truststore.

```
docker volume create kafka-ssl
```

## Setup Java Keystores

* Download Kafka key and certs.

```
mkdir -p /path/to/tmp/dir/
cd /path/to/tmp/dir
heroku config:get -a etison KAFKA_TRUSTED_CERT > kafka_trusted_cert.crt
heroku config:get -a etison KAFKA_CLIENT_CERT > kafka_client_cert.crt
heroku config:get -a etison KAFKA_CLIENT_CERT_KEY > kafka_client_cert.key
```

* Turn client key and cert into a single PKCS 12 file.  This will prompt you for a password.  Remember the password that you use.

```
openssl pkcs12 -export -in kafka_client_cert.crt -inkey kafka_client_cert.key -out kafka_client_cert.p12
```

* Run Kafka container to use keytool commands there.

```
docker run -it --rm -v `pwd`:/app --mount type=volume,source=kafka-ssl,destination=/kafka-ssl kafka bash
```

* Import CA cert.  This will prompt you for a password.  Remember the password that you use.

```
keytool -keystore /kafka-ssl/kafka.client.truststore.jks -alias ca -import -file kafka_trusted_cert.crt
```

* Import PKCS 12 cert.

```
keytool -importkeystore -destkeystore /kafka-ssl/kafka.client.keystore.jks -srckeystore kafka_client_cert.p12 -srcstoretype PKCS12
```

* Create `client-ssl.properties` file.

In `/kafka-ssl/client-ssl.properties`, ADD:

```
bootstrap.servers=kafka+ssl://ec2-18-204-113-178.compute-1.amazonaws.com:9096,kafka+ssl://ec2-34-236-252-65.compute-1.amazonaws.com:9096,kafka+ssl://ec2-18-232-47-73.compute-1.amazonaws.com:9096
security.protocol=SSL
ssl.endpoint.identification.algorithm=
ssl.truststore.location=/kafka-ssl/kafka.client.truststore.jks
ssl.truststore.password=[password from above]
ssl.keystore.location=/kafka-ssl/kafka.client.keystore.jks
ssl.keystore.password=[password from above]
ssl.key.password=[password from above]
```

* List consumer groups.

```
/kafka_2.12-2.2.1/bin/kafka-consumer-groups.sh --bootstrap-server kafka+ssl://ec2-18-204-113-178.compute-1.amazonaws.com:9096 --command-config /kafka-ssl/client-ssl.properties --list
```
