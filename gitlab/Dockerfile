FROM debian:stretch-slim

RUN set -x \
    && buildDeps=' \
        ca-certificates \
        wget \
        tar \
        openssh-server \
    '\
    && wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends $buildDeps \
        gitlab-ce \
    \