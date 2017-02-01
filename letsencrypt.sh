#!/bin/sh

COMMAND="certbot certonly --text --non-interactive --agree-tos --renew-by-default --webroot"

if [ ! -z "${LE_TEST}" ]; then
  COMMAND="${COMMAND} --staging"
fi

if [ ! -z "${LE_FQDNS}" ]; then
  ${COMMAND} --email "${LE_EMAIL}" -w ${WEBROOT} --domains ${LE_FQDNS}
  LE_FQDN=$(echo ${LE_FQDNS} | sed -n 's/\(.*\),.*/\1/p')
elif [ ! -z "${LE_FQDN}" ]; then
  ${COMMAND} --email "${LE_EMAIL}" -w ${WEBROOT} --domain ${LE_FQDN}
fi

cp -fv /etc/letsencrypt/live/$LE_FQDN/privkey.pem /etc/nginx/ssl/le-key.pem
cp -fv /etc/letsencrypt/live/$LE_FQDN/fullchain.pem /etc/nginx/ssl/le-crt.pem

