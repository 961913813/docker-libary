FROM debian:stretch-slim

RUN set -x \
    && buildDeps=' \
        ca-certificates \
        dpkg-dev \
        wget \
        tar \
        curl \
    '\
    && wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends $buildDeps \
        openssh-server \
        postfix \
    \
    && curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash \
    \