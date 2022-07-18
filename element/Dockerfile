ARG NGINX_VERSION=1.23.0

FROM nginxinc/nginx-unprivileged:${NGINX_VERSION}

USER 0

ARG ELEMENT_VERSION=1.11.0
ARG ELEMENT_TAR_HASH=03919ddbec5475f5fe5994099630d0b91dd7999884ee4de408129fd15a9e9f51

RUN curl -Lo /tmp/element-v${ELEMENT_VERSION}.tar.gz https://github.com/vector-im/element-web/releases/download/v1.11.0/element-v1.11.0.tar.gz && \
    printf "${ELEMENT_TAR_HASH}  /tmp/element-v${ELEMENT_VERSION}.tar.gz\\n" | sha256sum -c && \
    mkdir -p /usr/lib/element && \
    tar -xf /tmp/element-v${ELEMENT_VERSION}.tar.gz --strip-components=1 -C /usr/lib/element && \
    rm /tmp/element-v${ELEMENT_VERSION}.tar.gz

COPY element.nginx /etc/nginx/conf.d/default.conf

COPY --chmod=755 entrypoint.sh /docker-entrypoint.d/50-setup-element.sh
RUN touch /usr/lib/element/config.json && \
    chown 101 /usr/lib/element/config.json

USER 101
