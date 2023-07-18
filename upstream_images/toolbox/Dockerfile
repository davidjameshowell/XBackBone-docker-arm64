FROM alpine:3.18.2

RUN apk add --no-cache \
        ca-certificates \
        openssl \
        curl \
        bash \
        sed \
        wget \
        zip \
        unzip \
        bzip2 \
        p7zip \
        drill \
        ldns \
        openssh-client \
        rsync \
        git \
        gnupg \
    ## Install go-replace
    && wget -O "/usr/local/bin/go-replace" "https://github.com/webdevops/go-replace/releases/download/22.10.0/go-replace.linux.arm64" \
    && chmod +x "/usr/local/bin/go-replace" \
    && "/usr/local/bin/go-replace" --version

