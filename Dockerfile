FROM quay.io/strimzi/kafka:0.47.0-kafka-3.9.0
ARG PYRO_VERSION=v2.1.2

USER root

# Install pyroscope
RUN mkdir -p /opt/pyroscope && \
    curl -fL -o /opt/pyroscope/pyroscope.jar \
        https://github.com/grafana/pyroscope-java/releases/download/${PYRO_VERSION}/pyroscope.jar && \
    chown -R 1001:0 /opt/pyroscope && \
    chmod 644 /opt/pyroscope/pyroscope.jar

# Wrapper
RUN printf '%s\n' \
  '#!/usr/bin/env bash' \
  'set -euo pipefail' \
  'export PYROSCOPE_APPLICATION_NAME="${HOSTNAME:-kafka-broker}"' \
  'exec /opt/kafka/kafka_run.sh "$@"' \
  > /opt/kafka/bin/run_with_pyroscope.sh && \
  chmod +x /opt/kafka/bin/run_with_pyroscope.sh && \
  chown 1001:0 /opt/kafka/bin/run_with_pyroscope.sh

USER 1001
ENTRYPOINT ["/usr/bin/tini","-w","-s","--","/opt/kafka/bin/run_with_pyroscope.sh"]