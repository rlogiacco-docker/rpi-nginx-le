FROM rlogiacco/rpi-nginx

LABEL maintainer "Roberto Lo Giacco <rlogiacco@gmail.com>"
LABEL org.label-schema.vcs-url "https://github.com/rlogiacco-docker/rpi-nginx-le"

ENV HTDOCS /var/www/localhost/htdocs
ENV ALPINE_REPO http://dl-cdn.alpinelinux.org/alpine/v3.5

RUN echo "${ALPINE_REPO}/main" >> /etc/apk/repositories \
 && echo "${ALPINE_REPO}/community" >> /etc/apk/repositories \
 && apk add --no-cache certbot openssl \
 && rm -f /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh
COPY letsencrypt.sh /letsencrypt.sh

RUN chmod a+x /entrypoint.sh /letsencrypt.sh \
 && sed -i "s|\${HTDOCS}|${HTDOCS}|g" /etc/nginx/nginx.conf

VOLUME ["/etc/nginx/ssl"]

CMD /entrypoint.sh

