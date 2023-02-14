#!/bin/sh
# Start Nginx
nginx -g "daemon off;" &
NGINX_PID="$!"

# Restart on config change
inotifywait -e modify /www/nginx.conf
if nginx -t; then
    kill -SIGQUIT "$NGINX_PID"
fi

