FROM alpine:3.10

ENV NGINX_VERSION 1.16.1

RUN set -x \
# create nginx user/group first, to be consistent throughout docker variants
    && addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx \
    && apk add --no-cache  \
                gcc \
                libc-dev \
                make \
                openssl-dev \
                pcre-dev \
                zlib-dev \
                wget

ADD nginx-1.16.1.tar.gz /ss

RUN cd /ss \
        && wget https://github.com/arut/nginx-rtmp-module/archive/v1.2.1.tar.gz \
        && tar -xzvf v1.2.1.tar.gz  \
        && ls -al \
        && cd nginx-1.16.1 \
        && ./configure --with-http_ssl_module --add-module=/ss/nginx-rtmp-module-1.2.1 \
        && make CFLAGS='-Wno-implicit-fallthrough' -j 4 \
        && make install \
        && ln -sf /dev/stderr /usr/local/nginx/logs/error.log \
        && ln -sf /dev/stdout /usr/local/nginx/logs/access.log

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]