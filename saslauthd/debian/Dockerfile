FROM debian:stretch-slim
MAINTAINER Antainacme <gd.shunhua@qq.com>

RUN set -x\
    && apt-get update -y \ 
    && apt-get install -y --fix-missing --no-install-recommends sasl2-bin libsasl2-modules libsasl2-dev \
    \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i -n 's/START=no/START=yes/' /etc/default/saslauthd \