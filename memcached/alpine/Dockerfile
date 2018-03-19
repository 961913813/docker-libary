FROM knoms/saslauthd:alpine

ENV MEMCACHED_VERSION 1.5.4
ENV MEMCACHED_SHA1 29cb75cc234dbaceed6e89db029af8363706f0fe

RUN set -x \
	&& addgroup -S memcache && adduser -S -G memcache memcache \
	&& apk add --no-cache --virtual .build-deps \
		ca-certificates \
        coreutils \
		dpkg-dev dpkg\
		gcc \
		libc-dev \
        libressl \
		linux-headers \
		make \
		perl \
		wget \
		pwgen \
        tar \
        perl \
		perl-utils \
	\
    && apk add --no-cache libevent-dev \
    && wget -O memcached.tar.gz "https://memcached.org/files/memcached-$MEMCACHED_VERSION.tar.gz" \
    && echo "$MEMCACHED_SHA1  memcached.tar.gz" | sha1sum -c - \
	&& mkdir -p /usr/src/memcached \
	&& tar -xzf memcached.tar.gz -C /usr/src/memcached --strip-components=1 \
	&& rm memcached.tar.gz \
    \
	&& cd /usr/src/memcached \
	&& ./configure \
		--build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
		--enable-sasl \
	&& make -j "$(nproc)" \
	&& make test \
	&& make install \
	\
	&& cd / && rm -rf /usr/src/memcached \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	\
	&& apk add --virtual .memcached-rundeps $runDeps \
	&& apk del .build-deps \
	\
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& memcached -V

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh
EXPOSE 11211
ENTRYPOINT ["docker-entrypoint.sh"]