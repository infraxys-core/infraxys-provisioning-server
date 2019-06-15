from ubuntu:18.04

maintainer jeroen@manders.be

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget libcurl3 curl ftp git rsync \
    && apt-get install -y  libunwind8 zip apt-transport-https jq software-properties-common

VOLUME /infraxys
