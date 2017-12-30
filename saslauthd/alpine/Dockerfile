FROM alpine:3.7
MAINTAINER Atainacme <gd.shunhua@qq.com>
ENV CYRUS_SASL_VERSION 2.1.26

RUN set -x \
    && buildDeps=' \
        autoconf \
        automake \
	    gcc \
	    make \
		wget \
        curl \
        libc-dev \
        openldap-dev \
        tar \
        openssl-dev \
	' \
    && apk add --no-cache $buildDeps \
    #&& curl -fSL https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static -o /bin/tini \
    #&& chmod +x /bin/tini \
    \
    && wget -O cyrus-sasl.tar.gz ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-${CYRUS_SASL_VERSION}.tar.gz \
    && mkdir -p /usr/src/cyrus-sasl \
    && tar -xvf cyrus-sasl.tar.gz -C /usr/src/cyrus-sasl --strip-components=1 \
    && rm -f cyrus-sasl.tar.gz \
    && cd /usr/src/cyrus-sasl \
    && ./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --enable-auth-sasldb \
            --enable-login \
            --enable-ldapdb \
            --with-ldap=/usr \
            --with-dbpath=/var/lib/sasl/sasldb2 \
            --with-saslauthd=/var/run/saslauthd \
    && make -j"$(nproc)" \
    && make -j"$(nproc)" install \
    && apk del --purge ${buildDeps} \
    && rm -fr \
        /tmp/* \
        /var/tmp/* \
        /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/saslauthd"]
CMD ["-a", "ldap", "-d", "1"]