FROM knoms/debian-slim:sasl

ENV MEMCACHED_VERSION 1.5.3
ENV MEMCACHED_SHA1 9331ef99f1b7fedfe476062faed8c0ffb5528d8f

RUN set -x \
	&& groupadd -r memcache && useradd -r -g memcache memcache \
	&& buildDeps=' \
		ca-certificates \
		dpkg-dev \
		gcc \
		libc6-dev \
		make \
		perl \
		wget \
		pwgen \
	' \
	&& apt-get update && apt-get install -y --no-install-recommends $buildDeps \
			libevent-dev \
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
	&& apt-mark manual \
		libevent-2.0-5 \
		libsasl2-2 \
		libevent-dev \
	\
	&& apt-get purge -y --auto-remove $buildDeps \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& memcached -V
	
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && ln -s /usr/local/bin/docker-entrypoint.sh /entrypoint.sh
EXPOSE 11211
ENTRYPOINT ["docker-entrypoint.sh"]
