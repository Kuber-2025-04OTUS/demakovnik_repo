#!/bin/sh

# Запускаем Nginx
nginx

# Ждём stub_status
while ! curl -s http://localhost/stub_status >/dev/null; do
  sleep 1
done

# Запускаем экспортер от nginx
exec su-exec nginx:nginx \
  nginx-prometheus-exporter \
    -nginx.scrape-uri http://localhost/stub_status \
    -web.listen-address unix:/tmp/nginx_exporter.sock
