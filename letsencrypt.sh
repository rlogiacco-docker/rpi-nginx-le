#!/bin/sh

COMMAND="certbot certonly --text --non-interactive --agree-tos --renew-by-default --webroot -w ${HTDOCS}"

if [ ! -z "${LE_TEST}" ]; then
  COMMAND="${COMMAND} --staging"
fi

if [ ! -z "${LE_FQDNS}" ]; then
  ${COMMAND} --email "${LE_EMAIL}" --domains ${LE_FQDNS}
  LE_FQDN=$(echo ${LE_FQDNS} | sed -n 's/\(.*\),.*/\1/p')
elif [ ! -z "${LE_FQDN}" ]; then
  ${COMMAND} --email "${LE_EMAIL}" --domain ${LE_FQDN}
fi

SSL_KEY=/etc/nginx/ssl/le-key.pem
SSL_CERT=/etc/nginx/ssl/le-crt.pem

cp -fv /etc/letsencrypt/live/$LE_FQDN/privkey.pem ${SSL_KEY}
cp -fv /etc/letsencrypt/live/$LE_FQDN/fullchain.pem ${SSL_CERT}

#find /etc/nginx/conf.d.bak -type f -exec sed -i "s|\${SSL_KEY}|${SSL_KEY}|g" {} +
#find /etc/nginx/conf.d.bak -type f -exec sed -i "s|\${SSL_CERT}|${SSL_CERT}|g" {} +
