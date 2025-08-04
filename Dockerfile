FROM quay.io/strimzi/kafka:0.47.0-kafka-3.9.0
ARG PYRO_VERSION=v2.1.2
ADD https://github.com/grafana/pyroscope-java/releases/download/${PYRO_VERSION}/pyroscope.jar \
    /opt/pyroscope/pyroscope.jar
USER 1001