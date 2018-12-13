#!/usr/bin/env bash

set -e

REPO=zhangyuan/hadoop

DOCKER_USERNAME=${DOCKER_USERNAME}
DOCKER_PASSWORD=${DOCKER_PASSWORD}

VERSION=$TRAVIS_JOB_NUMBER
REVISION=$TRAVIS_COMMIT

docker build -f Dockerfile -t $REPO:$REVISION .
docker tag $REPO:$REVISION $REPO:latest
docker tag $REPO:$REVISION $REPO:$VERSION
docker tag $REPO:$REVISION $REPO:2.9.2

docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"

docker push $REPO

docker logout