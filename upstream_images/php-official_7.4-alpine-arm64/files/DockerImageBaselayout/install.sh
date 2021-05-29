#!/bin/sh

set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

TARGET_DIR="/"

if [ "$#" -eq 1 ]; then
    TARGET_DIR="$1"
    mkdir -p "$1"
fi

umask 0022

if [ -f "/sbin/apk" ]; then
    # Alpine linux
    apk add --no-cache ca-certificates wget --virtual .d2ViZGV2b3BzLWJhc2VsYXlvdXQ-deps
    update-ca-certificates
    wget -O /tmp/baselayout.tar.gz https://github.com/webdevops/Docker-Image-Baselayout/archive/master.tar.gz
    apk del .d2ViZGV2b3BzLWJhc2VsYXlvdXQ-deps
else
    # General linux
    wget -O /tmp/baselayout.tar.gz https://github.com/webdevops/Docker-Image-Baselayout/archive/master.tar.gz
fi

tar --no-same-permissions --strip-components=2 -xf /tmp/baselayout.tar.gz  -C "$TARGET_DIR"
rm -f /tmp/baselayout.tar.gz