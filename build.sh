#!/bin/sh

set -x

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Build Toolbox Image
cd "${SCRIPT_DIR}"/upstream_images/toolbox || exit
docker build -t nowaidavid/xbackbone-toolbox:latest -t nowaidavid/xbackbone-toolbox:"${GIT_SHA:-nosha}" .

# Build PHP image
cd "${SCRIPT_DIR}"/upstream_images/php-official_7.4-alpine-arm64 || exit
docker build -t nowaidavid/xbackbone-php:7.4-alpine-arm64 -t nowaidavid/xbackbone-php:7.4-alpine-arm64-"${GIT_SHA:-nosha}" .

# Build PHP-NGINX iamge
cd "${SCRIPT_DIR}"/upstream_images/php-nginx_alpine-php7-arm64 || exit
docker build -t nowaidavid/php-nginx:alpine-php7-arm64 -t nowaidavid/php-nginx:alpine-php7-arm64-"${GIT_SHA:-nosha}" .

# Build XBackBone image
cd "${SCRIPT_DIR}"/src || exit
docker build -t nowaidavid/xbackbone-docker-arm64:latest -t nowaidavid/xbackbone-docker-arm64:"${GIT_SHA:-nosha}" .

# Push Images
docker push nowaidavid/xbackbone-toolbox:latest
docker push nowaidavid/xbackbone-toolbox:"${GIT_SHA:-nosha}"

docker push nowaidavid/xbackbone-php:7.4-alpine-arm64
docker push nowaidavid/xbackbone-php:7.4-alpine-arm64-"${GIT_SHA:-nosha}"

docker push nowaidavid/php-nginx:alpine-php7-arm64
docker push nowaidavid/php-nginx:alpine-php7-arm64-"${GIT_SHA:-nosha}"

docker push nowaidavid/xbackbone-docker-arm64:latest
docker push nowaidavid/xbackbone-docker-arm64:"${GIT_SHA:-nosha}"

printf "All images pushed to Dockerhub and now avaliable for consumption"