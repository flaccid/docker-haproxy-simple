#!/bin/bash
set -e

# re-configures the haproxy config

# update the listen host and port, initial backend pool
sed -i "s/{BIND_HOST}/$BIND_HOST/g" /usr/local/etc/haproxy/haproxy.cfg
sed -i "s/{BIND_PORT}/$BIND_PORT/g" /usr/local/etc/haproxy/haproxy.cfg

echo 'binding:'
echo "    $BIND_HOST:$BIND_PORT"

# temporarily replace space with hyphon for use with bash array
BACKEND_HOSTS=${BACKEND_HOSTS// /-}

# backend hosts in backend pool if specified
if [ ! -z "$BACKEND_HOSTS" ]; then
  # currently only replacing pool is supported
  BACKEND_POOL=""
  hosts=(${BACKEND_HOSTS//,/ })

  echo 'backend hosts:'
  for host in "${hosts[@]}"
  do
    host=${host//-/ }
    echo "    ${host}"
    BACKEND_POOL="$BACKEND_POOL\n        server ${host}"
  done

  # append to the backend pool
  sed -i "s/{BACKEND_POOL}/$BACKEND_POOL/g" /usr/local/etc/haproxy/haproxy.cfg
fi

# copied from
# https://github.com/docker-library/haproxy/blob/master/1.6/alpine/docker-entrypoint.sh

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	# if the user wants "haproxy", let's use "haproxy-systemd-wrapper" instead so we can have proper reloadability implemented by upstream
	shift # "haproxy"
	set -- "$(which haproxy-systemd-wrapper)" -p /run/haproxy.pid "$@"
fi

exec "$@"
