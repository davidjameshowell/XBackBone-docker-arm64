#!/bin/sh

set -x

GIT_SHA_VAR=${1}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Build Toolbox Image
cd "${SCRIPT_DIR}"/upstream_images/toolbox || exit
docker build -t nowaidavid/xbackbone-toolbox:latest -t nowaidavid/xbackbone-toolbox:"${GIT_SHA_VAR:-nosha}" .

# Build PHP image
cd "${SCRIPT_DIR}"/upstream_images/php-official_8.2-alpine-arm64 || exit
docker build -t nowaidavid/xbackbone-php:8.2-alpine-arm64 -t nowaidavid/xbackbone-php:8.22-alpine-arm64-"${GIT_SHA_VAR:-nosha}" .

# Build PHP-NGINX iamge
cd "${SCRIPT_DIR}"/upstream_images/php-nginx_alpine-php8-arm64 || exit
docker build -t nowaidavid/xbackbone-php-nginx:alpine-php8-arm64 -t nowaidavid/xbackbone-php-nginx:alpine-php8-arm64-"${GIT_SHA_VAR:-nosha}" .

# Build XBackBone image
cd "${SCRIPT_DIR}"/src || exit
docker build -t nowaidavid/xbackbone-docker-arm64:latest -t nowaidavid/xbackbone-docker-arm64:"${GIT_SHA_VAR:-nosha}" .

# Push Images
docker image push nowaidavid/xbackbone-toolbox:latest
docker image push nowaidavid/xbackbone-toolbox:"${GIT_SHA_VAR:-nosha}"

docker image push nowaidavid/xbackbone-php:8.2-alpine-arm64
docker image push nowaidavid/xbackbone-php:8.2-alpine-arm64-"${GIT_SHA_VAR:-nosha}"

docker image push nowaidavid/xbackbone-php-nginx:alpine-php8-arm64
docker image push nowaidavid/xbackbone-php-nginx:alpine-php8-arm64-"${GIT_SHA_VAR:-nosha}"

docker image push nowaidavid/xbackbone-docker-arm64:latest
docker image push nowaidavid/xbackbone-docker-arm64:"${GIT_SHA_VAR:-nosha}"

printf "All images pushed to Dockerhub and now avaliable for consumption"