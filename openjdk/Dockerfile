FROM openjdk:8-alpine

RUN apk update && apk add --no-cache --virtual .build-deps curl bash tree\
    && apk add tzdata \
    && cp -r -f /usr/share/zoneinfo/Hongkong /etc/localtime \
    && echo -ne "Alpine Linux 3.4 image. (`uname -rsv`)\n" >> /root/.built \
    && apk del .build-deps 
