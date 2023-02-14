FROM alpine:latest

# Add "nginx" user(& group)
RUN addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -s /sbin/nologin -G nginx -g nginx nginx

# Update image & Add components
RUN apk update \
    && apk --no-cache upgrade \
    && apk --no-cache add supervisor inotify-tools nginx nginx-mod-http-brotli php81-fpm php81-curl php81-fileinfo php81-gd php81-gettext \
                            php81-mbstring php81-mysqli php81-opcache php81-openssl php81-pdo php81-pdo_mysql php81-pdo_pgsql php81-pdo_sqlite \
                            php81-phar php81-session php81-sockets

# Set log redirection
RUN mkdir -p /var/log/nginx /var/log/php81 \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && ln -sf /dev/stderr /var/log/php81/error.log

# Update PHP-FPM config
RUN sed -i -E "s/^(user|group)\s*=\s*nobody$/\1 = nginx/g" /etc/php81/php-fpm.d/www.conf \
    && sed -i -E "s/^listen\s*=\s*.*$/listen = \/run\/nginx\/php-fpm.sock/" /etc/php81/php-fpm.d/www.conf \
    && sed -i -E "s/^;listen\.(owner|group)\s*=\s*(.*)$/listen.\1 = nginx/g" /etc/php81/php-fpm.d/www.conf

# Setup "app" directory
COPY ./app /app

# Setup "www" directory
COPY ./www /www
VOLUME /www
RUN ln -sf /www/nginx.conf /etc/nginx/http.d/default.conf \
    && chown nginx:nginx -R /www/public

# Container entry point
EXPOSE 80 443
ENTRYPOINT ["supervisord", "-c", "/app/supervisord.conf"]

