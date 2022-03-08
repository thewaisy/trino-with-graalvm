#!/bin/bash

DOCKER_USER=waisy
TRINO_VERSION=372
VM=graalvm
PYTHON_VERSION=3.8.12
# TRINO_BIN

set -e

# TRINO
docker build \
    -t ${DOCKER_USER}/trino:${TRINO_VERSION}-${VM}-${PYTHON_VERSION} \
    --build-arg TRINO_VERSION=$TRINO_VERSION \
    --build-arg PYTHON_VERSION=$PYTHON_VERSION \
    ./docker


