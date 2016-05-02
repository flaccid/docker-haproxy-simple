FROM haproxy:alpine

MAINTAINER Chris Fordham <chris@fordham-nagy.id.au>

ENV BIND_HOST='*' BIND_PORT='80'
ENV BACKEND_HOSTS="icanhazip1 64.182.208.181,icanhazip2 64.182.208.182"
ENV BACKEND_POOL "        server icanhazip1 64.182.208.181\n        server icanhazip2 64.182.208.182"

# bash arrays are used in the entrypoint
RUN apk add --update bash && rm -rf /var/cache/apk/*

COPY entry.sh /usr/local/bin/entry.sh
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

ENTRYPOINT ["/usr/local/bin/entry.sh"]

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
