#!/bin/sh
set -e

nsd-checkconf /etc/nsd/nsd.conf
# Then each time a change is made to the zone (including when you first start the server), 
# you need to rebuild the NSD zone databases:
nsdc rebuild
# set it to auto-start
rc-update add nsd
# start the server
if [ "$1" = "/etc/init.d/nsd" -a "$(id -u)" = '0' ]; then
    echo "$@"
fi
exec "$@"
