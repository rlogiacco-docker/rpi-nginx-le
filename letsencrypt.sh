#!/bin/sh

COMMAND="certbot certonly --text --non-interactive --agree-tos --renew-by-default --webroot -w /var/www/localhost/html"

if [ ! -z "${LE_TEST}" ]; then
  COMMAND="${COMMAND} --staging"
fi

if [ ! -z "${LE_FQDNS}" ]; then
  ${COMMAND} --email "${LE_EMAIL}" --domains ${LE_FQDNS}
  LE_FQDN=$(echo ${LE_FQDNS} | sed -n 's/\(.*\),.*/\1/p')
elif [ ! -z "${LE_FQDN}" ]; then
  ${COMMAND} --email "${LE_EMAIL}" --domain ${LE_FQDN}
fi

cp -fv /etc/letsencrypt/live/$LE_FQDN/privkey.pem /etc/nginx/ssl/le-key.pem
cp -fv /etc/letsencrypt/live/$LE_FQDN/fullchain.pem /etc/nginx/ssl/le-crt.pem

