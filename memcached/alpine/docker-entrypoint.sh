#!/bin/sh
set -e

USER=${MEMCACHED_USERNAME:-memcached}
PASS=${MEMCACHED_PASSWORD:-$MEMCACHED_PWD}

echo  mech_list: plain >/usr/lib/sasl2/memcached.conf
chown root:root /etc/sasldb2
/etc/init.d/saslauthd restart
echo $PASS | saslpasswd2 -a memcached -c $USER -p

memcached -u root -S -l 0.0.0.0 $@
