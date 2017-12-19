#!/bin/sh
set -e

USER=${MEMCACHED_USERNAME:-memcached}
PASS=${MEMCACHED_PASSWORD:-$MEMCACHED_PWD}

echo "Creating user: \"$USER\"..."
echo  /usr/lib/sasl2/memcached.conf
echo $PASS | saslpasswd2 -a memcached -c $USER -p
# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- memcached "$@"
fi

exec "$@"