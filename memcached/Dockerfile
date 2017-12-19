FROM debian:stretch-slim

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r memcache && useradd -r -g memcache memcache

ENV MEMCACHED_VERSION 1.5.3
ENV MEMCACHED_SHA1 9331ef99f1b7fedfe476062faed8c0ffb5528d8f
ENV CRYUS_SASL_SHA1 a7f4e5e559a0e37b3ffc438c9456e425

RUN set -x \
	&& buildDeps=' \
		ca-certificates \
		dpkg-dev \
		gcc \
		libc6-dev \
		libevent-dev \
		make \
		perl \
		wget \
		pwgen \
	' \
	&& apt-get update && apt-get install -y --no-install-recommends $buildDeps \
		libsasl2-dev \
        sasl2-bin \
	\
	&& rm -rf /var/lib/apt/lists/* \
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
	\
	&& make test \
	&& make install \
	\
	&& cd / && rm -rf /usr/src/memcached \
        && export MEMCACHED_PWD="$(pwgen -s -1 16)" \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& memcached -V
	
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

USER memcache
EXPOSE 11211
CMD ["memcached"]
