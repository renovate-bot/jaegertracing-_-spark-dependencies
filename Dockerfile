#
# Copyright (c) The Jaeger Authors
# SPDX-License-Identifier: Apache-2.0
#

# Simple runtime image that receives a pre-built JAR from the host
FROM eclipse-temurin:21.0.13_9-jre@sha256:0b99b3376fbb50dbf9c0af8535fdd5b8eb0d3fdfc8b1e4967f383b6919f6901a
LABEL org.opencontainers.image.authors="The Jaeger Authors <cncf-jaeger-maintainers@lists.cncf.io>"

# Build argument to specify the variant type
# Supported values: cassandra, elasticsearch7, elasticsearch8, elasticsearch9
ARG VARIANT=elasticsearch9

ENV APP_HOME=/app/
ENV VARIANT_TYPE=${VARIANT}

# The JAR is provided by the GHA runner into the artifact-target folder
COPY artifact-target/jaeger-spark-dependencies*.jar $APP_HOME/app.jar

WORKDIR $APP_HOME

COPY entrypoint.sh /

RUN chgrp root /etc/passwd && chmod g+rw /etc/passwd
USER 185

ENTRYPOINT ["/entrypoint.sh"]
