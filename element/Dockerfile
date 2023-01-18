ARG NGINX_VERSION=1.23.3

FROM nginxinc/nginx-unprivileged:${NGINX_VERSION}

USER 0

ARG ELEMENT_VERSION=1.11.18
ARG ELEMENT_TAR_HASH=61d94598aec6e793563277831b9eb39cc64f85297d67c5ea49b243b182278dc5

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
