#!/bin/bash
USER=${MEMCACHED_USERNAME:-memcached}
PASS=${MEMCACHED_PASSWORD:-$(pwgen -s -1 16)}

# Create User
echo "Creating user: \"$USER\"..."
echo  /usr/lib/sasl2/memcached.conf
echo $PASS | saslpasswd2 -a memcached -c $USER -p