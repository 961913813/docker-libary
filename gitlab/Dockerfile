FROM debian:stretch-slim

RUN set -x \
    && buildDeps=' \
        ca-certificates \
        dpkg-dev \
        wget \
        tar \
        openssh-server \
    '\
    && wget -q -O - https://packages.gitlab.com/gpg.key | apt-key add - \
  #  && EXTERNAL_URL="http://gitlab.example.com" dpkg -i gitlab-ee-9.5.2-ee.0_amd64.deb \
    && apt-get update && apt-get install -y --no-install-recommends $buildDeps \
        gitlab-ce \
    \