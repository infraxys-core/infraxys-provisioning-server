#!/bin/bash

set -e;

VERSION="$(cat VERSION)";

docker build -t quay.io/jeroenmanders/docker-infraxys-provisioning-server:$VERSION .;

docker tag quay.io/jeroenmanders/docker-infraxys-provisioning-server:$VERSION quay.io/jeroenmanders/docker-infraxys-provisioning-server:latest

docker push quay.io/jeroenmanders/docker-infraxys-provisioning-server:$VERSION;
docker push quay.io/jeroenmanders/docker-infraxys-provisioning-server:latest;
