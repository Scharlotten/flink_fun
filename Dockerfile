# We're using Java 8 here instead of 11 because Flink issues reflection
# warnings on Java 11. See FLINK-17254 for more information:
# https://issues.apache.org/jira/browse/FLINK-17524
FROM flink:1.15.2-scala_2.12-java8

# Add Flink dependencies
ADD https://github.com/knaufk/flink-faker/releases/download/v0.5.0/flink-faker-0.5.0.jar /opt/flink/lib/
ADD https://repo1.maven.org/maven2/org/apache/flink/flink-connector-kafka/1.15.2/flink-connector-kafka-1.15.2.jar /opt/flink/lib/
ADD https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/3.3.2/kafka-clients-3.3.2.jar /opt/flink/lib/

# S3 dependencies
ADD https://repo1.maven.org/maven2/org/apache/flink/flink-s3-fs-hadoop/1.15.2/flink-s3-fs-hadoop-1.15.2.jar /opt/flink/lib/

# Flink Table Store dependencies
ADD https://repo1.maven.org/maven2/org/apache/flink/flink-table-store-dist/0.2.1/flink-table-store-dist-0.2.1.jar /opt/flink/lib/
ADD https://repo.maven.apache.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar /opt/flink/lib/

# The Flink image expects dependencies to be owned by the flink user
RUN chown -R flink:flink /opt/flink/lib/

# Add Kafka binaries so we can pre-create topics
RUN mkdir /opt/kafka
ADD https://downloads.apache.org/kafka/3.3.2/kafka_2.12-3.3.2.tgz /tmp/
RUN tar -xf /tmp/kafka*.tgz -C /opt/kafka --strip-components 1