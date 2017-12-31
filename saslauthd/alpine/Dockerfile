FROM alpine:3.7
MAINTAINER Atainacme <gd.shunhua@qq.com>
ENV CYRUS_SASL_VERSION=2.1.26 \
    TINI_VERSION=0.8.3

RUN set -x \
    && buildDeps=' \
        autoconf \
        automake \
	    gcc g++\
	    make \
		wget \
        curl \
        tar \
        libc-dev \
        db-dev \
        libtool \
        openssl-dev \
        heimdal-dev \
        openldap-dev \
	' \
    && apk add --no-cache $buildDeps \
       libldap \
    && curl -fSL https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static -o /bin/tini \
    && chmod +x /bin/tini \
    \
    && wget -O cyrus-sasl.tar.gz ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-${CYRUS_SASL_VERSION}.tar.gz \
    && curl -fL http://git.alpinelinux.org/cgit/aports/plain/main/cyrus-sasl/cyrus-sasl-${CYRUS_SASL_VERSION}-avoid_pic_overwrite.patch?h=3.2-stable -o /tmp/cyrus-sasl-avoid_pic_overwrite.patch \
    && curl -fL http://git.alpinelinux.org/cgit/aports/plain/main/cyrus-sasl/cyrus-sasl-${CYRUS_SASL_VERSION}-size_t.patch?h=3.2-stable -o /tmp/cyrus-sasl-size_t.patch \
    && curl -fL http://www.linuxfromscratch.org/patches/blfs/svn/cyrus-sasl-${CYRUS_SASL_VERSION}-fixes-3.patch -o /tmp/cyrus-sasl-fixes-3.patch \
    && curl -fL http://www.linuxfromscratch.org/patches/blfs/svn/cyrus-sasl-${CYRUS_SASL_VERSION}-openssl-1.1.0-1.patch -o /tmp/cyrus-sasl-openssl-1.1.0-1.patchh \
    && mkdir -p /usr/src/cyrus-sasl \
    && tar -xvf cyrus-sasl.tar.gz -C /usr/src/cyrus-sasl --strip-components=1 \
    && rm -f cyrus-sasl.tar.gz \
    && cd /usr/src/cyrus-sasl \
    && patch -p1 -i /tmp/cyrus-sasl-avoid_pic_overwrite.patch || true \
    && patch -p1 -i /tmp/cyrus-sasl-size_t.patch || true \
    && patch -Np1 -i ../cyrus-sasl-2.1.26-fixes-3.patch \
    && patch -Np1 -i ../cyrus-sasl-2.1.26-openssl-1.1.0-.patch \
    && autoreconf -fi \
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

VOLUME ["/var/run/saslauthd"]
ENTRYPOINT ["/bin/tini", "--", "/usr/sbin/saslauthd"]
CMD ["-a", "-d", "1"]