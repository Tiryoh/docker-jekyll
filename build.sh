#!/usr/bin/env bash
set -eu

JEKYLL_VERSION=${JEKYLL_VERSION:-4.2.0}
DOCKER_HUB_USER="tiryoh"
DOCKER_TAG_BASE="jekyll"
DOCKER_TAG="$DOCKER_TAG_BASE:$JEKYLL_VERSION"
RUBYOPT="-W0"

if git rev-parse --verify HEAD > /dev/null 2>&1 ; then
    COMMIT_HASH="$(git rev-parse --verify HEAD)"
else
    COMMIT_HASH="null"
fi

# docker buildx build \
#  --platform linux/arm64 \
docker build \
 --build-arg BASE_IMAGE=ruby:3.4.2-alpine3.21 \
 --build-arg RUBYOPT=$RUBYOPT \
 --build-arg JEKYLL_DOCKER_TAG=$JEKYLL_VERSION \
 --build-arg JEKYLL_VERSION=$JEKYLL_VERSION \
 --build-arg JEKYLL_DOCKER_COMMIT=$COMMIT_HASH \
 --build-arg JEKYLL_DOCKER_NAME=$DOCKER_TAG_BASE \
 -f Dockerfile .
