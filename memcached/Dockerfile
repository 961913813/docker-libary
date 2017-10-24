FROM memcached:latest
MAINTAINER gdyang <gd.shunhua@qq.com>

ENV BITNAMI_APP_NAME="memcached" \
    MEMCACHED_PASSWORD="" \
    MEMCACHED_USERNAME="root"

RUN apt-get install -y --force-yes \
    sasl2-bin \
    libsasl2-modules

RUN chown memcache:memcache /etc/sasldb2
