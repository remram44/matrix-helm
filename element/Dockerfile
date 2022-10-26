ARG NGINX_VERSION=1.23.2

FROM nginxinc/nginx-unprivileged:${NGINX_VERSION}

USER 0

ARG ELEMENT_VERSION=1.11.12
ARG ELEMENT_TAR_HASH=62469002d03600c220de90b6f009f4b1016d2bdeb2255145c544f3144ddd1c84

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
