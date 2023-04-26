ARG NGINX_VERSION=1.24.0

FROM nginxinc/nginx-unprivileged:${NGINX_VERSION}

USER 0

ARG ELEMENT_VERSION=1.11.30
ARG ELEMENT_TAR_HASH=35f718ff31967b9b90b7b3075d6844d5dbdcba9b5c1cc29d0cc50f0dc2bb7102

RUN curl -Lo /tmp/element-v${ELEMENT_VERSION}.tar.gz https://github.com/vector-im/element-web/releases/download/v${ELEMENT_VERSION}/element-v${ELEMENT_VERSION}.tar.gz && \
    printf "${ELEMENT_TAR_HASH}  /tmp/element-v${ELEMENT_VERSION}.tar.gz\\n" | sha256sum -c && \
    mkdir -p /usr/lib/element && \
    tar -xf /tmp/element-v${ELEMENT_VERSION}.tar.gz --strip-components=1 -C /usr/lib/element && \
    rm /tmp/element-v${ELEMENT_VERSION}.tar.gz

COPY element.nginx /etc/nginx/conf.d/default.conf

COPY --chmod=755 entrypoint.sh /docker-entrypoint.d/50-setup-element.sh
RUN touch /usr/lib/element/config.json && \
    chown 101 /usr/lib/element/config.json

USER 101
