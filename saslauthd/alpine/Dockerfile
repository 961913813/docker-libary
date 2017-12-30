FROM alpine:3.7

ENV CYRUS_SASL_VERSION 2.1.26
ENV CYRUS_SASL_SHA1 a7f4e5e559a0e37b3ffc438c9456e425

RUN set -x \
    && DEBIAN_FRONTEND=noninteractive \
    && buildDeps=' \
        autoconf \
        automake \
		gcc \
		make \
		wget \
        libc-dev \
        tar \
        openssl-dev \
	' \
    && apk add --no-cache $buildDeps \
    \
    && wget -O cyrus-sasl.tar.gz ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-${CYRUS_SASL_VERSION}.tar.gz \
    && echo "$CYRUS_SASL_SHA1  cyrus-sasl.tar.gz" | sha1sum -c - \
    && mkdir -p /usr/src/cyrus-sasl \
    && tar -xvf cyrus-sasl.tar.gz -C /usr/src/cyrus-sasl --strip-components=1 \
    && rm -f cyrus-sasl.tar.gz \
    && cd /usr/src/cyrus-sasl \
    && ./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --enable-auth-sasldb \
            --enable-login \
            --with-dbpath=/var/lib/sasl/sasldb2 \
            --with-saslauthd=/var/run/saslauthd \
    && make -j"$(nproc)" \
    && make -j"$(nproc)" install \
    && apk del --purge ${buildDeps} \
    && rm -fr \
        /tmp/* \
        /var/tmp/* \
        /var/cache/apk/*