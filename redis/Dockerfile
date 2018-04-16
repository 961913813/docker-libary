FROM redis:4.0.8-alpine

ENV REDIS_PASSWORD 123456
COPY redis.conf /etc/redis/redis.conf

RUN mkdir -p /var/lib/redis  /var/run/redis/ \
    && chmod -R 0755 /var/run/redis \
    && chown -R  redis:redis /var/run/redis \
    sed -i "/# requirepass/a\requirepass $REDIS_PASSWORD" /etc/redis/redis.conf 

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "redis-server", "/etc/redis/redis.conf"]