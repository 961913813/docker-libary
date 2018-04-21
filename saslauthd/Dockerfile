FROM alpine:3.7
MAINTAINER tinyforegoer<tinyforegoer@163.com>

ENV CYRUS_SASL_VERSION=2.1.26 \
    TINI_VERSION=0.8.3

RUN set -x \
    && mkdir -p /etc/saslauthd.d /tmp/cyrus-sasl /var/run/saslauthd \
    && buildDeps=' \
        autoconf \
        automake \
        db-dev \
	    gcc g++\
	    make \
        curl \
        tar \
        libtool \
        db-dev \
        libtool \
        heimdal-dev \
        openldap-dev \
	' \
    && apk add --update $buildDeps \
        cyrus-sasl \
        libldap 
RUN curl -fSL https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static -o /bin/tini \
    && chmod +x /bin/tini \
    && curl -fSL ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-${CYRUS_SASL_VERSION}.tar.gz -o /tmp/cyrus-sasl.tgz \
    && curl -fSL http://www.linuxfromscratch.org/patches/blfs/svn/cyrus-sasl-${CYRUS_SASL_VERSION}-fixes-3.patch -o /tmp/cyrus-sasl-fixes-3.patch \
    && curl -fSL http://www.linuxfromscratch.org/patches/blfs/svn/cyrus-sasl-${CYRUS_SASL_VERSION}-openssl-1.1.0-1.patch -o /tmp/cyrus-sasl-openssl-1.1.0-1.patch \
    && curl -fL http://git.alpinelinux.org/cgit/aports/plain/main/cyrus-sasl/cyrus-sasl-2.1.25-avoid_pic_overwrite.patch?h=3.2-stable -o /tmp/cyrus-sasl-2.1.25-avoid_pic_overwrite.patch \
    && curl -fL http://git.alpinelinux.org/cgit/aports/plain/main/cyrus-sasl/cyrus-sasl-2.1.26-size_t.patch?h=3.2-stable -o /tmp/cyrus-sasl-2.1.26-size_t.patch \
    && tar -xzf /tmp/cyrus-sasl.tgz --strip=1 -C /tmp/cyrus-sasl 
RUN cd /tmp/cyrus-sasl \
    # && patch -Np1 -i /tmp/cyrus-sasl-fixes-3.patch || true \
    # && patch -Np1 -i /tmp/cyrus-sasl-openssl-1.1.0-1.patch || true \
    && patch -p1 -i /tmp/cyrus-sasl-2.1.25-avoid_pic_overwrite.patch || true \
    && patch -p1 -i /tmp/cyrus-sasl-2.1.26-size_t.patch || true \
    && autoreconf -fi \
    && ./configure --prefix=/usr \
            --sysconfdir=/etc    \
            --enable-auth-sasldb \
            --enable-digest \
            --enable-login \
            --enable-ldapdb \
            --enable-ntlm \
            --disable-otp \
            --enable-plain \
            --with-ldapdb \
            --with-ldap=/usr \
            --with-dbpath=/var/lib/sasl/sasldb2 \
            --with-saslauthd=/var/run/saslauthd  \
            --localstatedir=/var/lib/sasl \
            --with-openssl=/usr \
    && make -j"$(nproc)" \
    && make -j"$(nproc)" install 
RUN apk del --purge ${buildDeps} \
    && rm -fr \
        /tmp/* \
        /var/tmp/* \
        /var/cache/apk/*

VOLUME ["/var/run/saslauthd"]
ENTRYPOINT ["/bin/tini", "--", "/usr/sbin/saslauthd"]
CMD ["-a", "ldap", "-d", "1"]