FROM quay.io/choros/php-docker:7.2.7

RUN set -xe \
	&& apk add --no-cache \
          supervisor \
          nginx \
          sed \
          coreutils \
        && mkdir /app \
        && chown www-data:www-data /app

RUN set -xe \
        && docker-php-source download \
        && docker-php-ext-install -j$(nproc) pdo_mysql opcache \
        && docker-php-source delsrc

COPY conf/ /opt/docker/
COPY usr/ /usr

ENV WEB_DOCUMENT_ROOT /app
ENV WEB_DOCUMENT_INDEX index.php
ENV WEB_ALIAS_DOMAIN test.vm
ENV WEB_PHP_SOCKET 127.0.0.1:9000

EXPOSE 80
ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]
CMD ["supervisord"]
