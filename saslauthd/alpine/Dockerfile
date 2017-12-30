FROM alpine:3.7

RUN set -x \
    && buildDeps=' \
		gcc \
		make \
		wget \
        libc-dev \
        tar \
	' \
    && apk add --no-cache $buildDeps \
    \
    && wget -O cyrus-sasl.tar.gz ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz \
    && mkdir -p /usr/src/cyrus-sasl \
    && tar -xvf cyrus-sasl.tar.gz -C /usr/src/cyrus-sasl --strip-components=1 \
    && rm -f cyrus-sasl.tar.gz \
    && cd /usr/src/cyrus-sasl \
    && ./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --enable-auth-sasldb \
            --with-dbpath=/var/lib/sasl/sasldb2 \
            --with-saslauthd=/var/run/saslauthd \
    && make