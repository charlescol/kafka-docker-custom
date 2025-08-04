FROM quay.io/strimzi/kafka:0.47.0-kafka-3.9.0
ARG PYRO_VERSION=v2.1.2

USER root
RUN mkdir -p /opt/pyroscope && \
    curl -fL -o /opt/pyroscope/pyroscope.jar \
    https://github.com/grafana/pyroscope-java/releases/download/${PYRO_VERSION}/pyroscope.jar && \
    chown -R 1001:0 /opt/pyroscope && \
    chmod 644 /opt/pyroscope/pyroscope.jar

USER 1001