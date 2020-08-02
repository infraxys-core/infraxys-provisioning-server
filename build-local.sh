#!/usr/bin/env bash

set -euo pipefail;

VERSION_LATEST="$(cat VERSION_LATEST)"
docker build -f Dockerfile -t quay.io/jeroenmanders/infraxys-provisioning-server:$VERSION_LATEST .;
