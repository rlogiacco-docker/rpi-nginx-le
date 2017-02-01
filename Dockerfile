FROM rlogiacco/rpi-nginx

LABEL maintainer "rlogiacco@gmail.com"

ENV HTTP_ROOT /var/www/localhost/html

RUN \
  apk add --no-cache certbot openssl &&\
  rm -f /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh
COPY letsencrypt.sh /letsencrypt.sh

RUN chmod a+x /entrypoint.sh /letsencrypt.sh

VOLUME ["/etc/nginx/ssl"]

CMD /entrypoint.sh

