FROM alpine:3.7

RUN set -x \
    && apk add --no-cache nsd
    
ADD ./nsd /etc/nsd
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "/etc/init.d/nsd", "start"]

