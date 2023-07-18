#!/bin/sh
docker buildx build --pull \
    . \
    --platform linux/amd64,linux/arm/v5,linux/arm/v7,linux/arm64,linux/ppc64le \
    --push --tag quay.io/remram44/element:1.11.36
