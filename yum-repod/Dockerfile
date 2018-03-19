FROM centos:7
MAINTAINER atchen <gd.shunhua@qq.com>

ENV TZ "Asia/Shanghai" 
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && yum update -y \
    && yum install -y createrepo wget gcc make pcre-devel zlib-devel \
    && wget http://nginx.org/download/nginx-1.8.0.tar.gz  -O nginx.tar.gz \
    && mkdir -p /usr/src/nginx \
    && tar -xvf nginx.tar.gz -C /usr/src/nginx --strip-components=1 \
    && rm -f nginx.tar.gz \
    && cd /usr/src/nginx \
    && ./configure   --prefix=/usr/local/nginx   --with-pcre \
    && make \
    && make install \
    && /usr/local/nginx/sbin/nginx \
    && yum remove -y wget gcc make pcre-devel zlib-devel

EXPOSE 80
EXPOSE 443

