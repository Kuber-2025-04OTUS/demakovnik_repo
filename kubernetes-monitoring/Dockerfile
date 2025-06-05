FROM nginx:alpine

RUN apk add --no-cache curl su-exec && \
    mkdir -p /tmp && chown nginx:nginx /tmp && \
    curl -Lo /tmp/exporter.tar.gz \
    https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.11.0/nginx-prometheus-exporter_0.11.0_linux_amd64.tar.gz && \
    tar xzf /tmp/exporter.tar.gz -C /tmp && \
    mv /tmp/nginx-prometheus-exporter /usr/local/bin/ && \
    chmod +x /usr/local/bin/nginx-prometheus-exporter && \
    rm /tmp/exporter.tar.gz

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
