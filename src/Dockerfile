FROM nowaidavid/php-nginx:alpine-php7-arm64
MAINTAINER David Howell <david@davidjameshowell.com>

ARG XBACKBONE_VERSION=3.3.5
ENV APP_NAME=XBackBone
ENV URL=http:\/\/127.0.0.1

ADD ./nginx.conf /opt/docker/etc/nginx/vhost.common.d/11-xbackbone.conf
ADD ./configure.sh /opt/docker/provision/entrypoint.d/01-app.sh
ADD ./cloudflared.conf /opt/docker/etc/supervisor.d/cloudflared.conf

USER application

RUN wget "https://github.com/SergiX44/XBackBone/releases/download/${XBACKBONE_VERSION}/release-v${XBACKBONE_VERSION}.zip" -O /app/master.zip; \
        cd /app; \
        unzip master.zip; \
        rm master.zip; \
	    mkdir -p /app/config \
        wget "https://github.com/cloudflare/cloudflared/releases/download/2021.5.10/cloudflared-linux-arm64" -O /opt/docker/cloudflared; \
        chmod +x /opt/docker/cloudflared

VOLUME [ "/app/storage", "/app/resources/database", "/app/logs", "/app/config"]

#Fix #3
USER root

# Necessary for Cloudflare to operate - see https://github.com/cloudflare/cloudflared/issues/205
RUN apk --no-cache add libc6-compat
