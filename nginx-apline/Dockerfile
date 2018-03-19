FROM alpine:3.7
LABEL maintainer="NGINX Docker Maintainers <gd.shunhua@qq.com>"

ENV NGINX_VERSION 1.13.9
ENV LUAJIT_VERSION 2.1.0-beta3
ENV LUAJIT_LIB /usr/local/lib
ENV LUAJIT_INC /usr/local/include/luajit-2.1
  
RUN set -x \
    && addgroup -S nginx \
    && adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx \
    && apk add --no-cache --virtual .build-deps \
		gcc \
		libc-dev \
        zlib-dev \
        pcre-dev \
        gd-dev \
        geoip-dev \
        libxslt-dev \
		make \
		linux-headers \
        wget \
		curl \
		gnupg \
		perl-dev \
        unzip \
    && apk add --no-cache openssl pcre zlib gd geoip libxslt libgcc perl \
    && wget -O nginx.tar.gz http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz \
    && wget -O ngx_devel_kit.tar.gz https://codeload.github.com/simplresty/ngx_devel_kit/tar.gz/v0.3.1rc1 --no-check-certificate  \
    && wget -O lua-nginx-module.tar.gz https://codeload.github.com/openresty/lua-nginx-module/tar.gz/v0.10.12rc2 --no-check-certificate \
    && wget -O LuaJIT.tar.gz http://luajit.org/download/LuaJIT-$LUAJIT_VERSION.tar.gz \
    && mkdir -p /usr/src/nginx /usr/local/lua-nginx-module /usr/local/ngx_devel_kit /usr/src/luaJIT \
    && tar -xzf nginx.tar.gz -C /usr/src/nginx --strip-components=1 \
    && tar -xzf lua-nginx-module.tar.gz -C /usr/local/lua-nginx-module --strip-components=1 \
    && tar -xzf ngx_devel_kit.tar.gz -C /usr/local/ngx_devel_kit --strip-components=1 \
    && tar -xzf LuaJIT.tar.gz -C /usr/src/luaJIT --strip-components=1 \
    && rm -f nginx.tar.gz lua-nginx-module.tar.gz ngx_devel_kit.tar.gz LuaJIT.tar.gz \
    && cd /usr/src/luaJIT \
    && make -j $(getconf _NPROCESSORS_ONLN) \
    && make install \
    && cd /usr/src/nginx \
    && ./configure --prefix=/usr/local/nginx \
         --with-http_perl_module \
         --with-ld-opt="-Wl,-rpath,$LUAJIT_LIB" \
         --add-module=/usr/local/ngx_devel_kit \
         --add-module=/usr/local/lua-nginx-module \
    && make -j $(getconf _NPROCESSORS_ONLN) \
    && make install \
    && make clean \
    && rm -rf $LUAJIT_LIB/libluajit-5.1.a $LUAJIT_INC \
    && strip -s /usr/local/nginx/sbin/nginx \
	&& apk --no-cache del .build-deps \
    && rm -rf /usr/local/lua-nginx-module /usr/local/ngx_devel_kit /usr/src/luaJIT /usr/src/nginx \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
	&& ln -sf /dev/stderr /usr/local/nginx/logs/error.log \
    && sed -i '/mime.types/a\include /usr/local/nginx/conf.d/*.conf;' /usr/local/nginx/conf/nginx.conf 

EXPOSE 80 443
STOPSIGNAL SIGTERM
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]