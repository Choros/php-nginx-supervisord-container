#!/usr/bin/env bash

source /opt/docker/bin/config.sh

includeScriptDir "/opt/docker/bin/service.d/php-fpm.d/"

exec /usr/local/sbin/php-fpm --nodaemonize -y /opt/docker/etc/php/fpm/php-fpm.conf
