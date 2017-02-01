#!/bin/sh

#set TZ
if [ ! -z "${TZ}" ]; then
  cp /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone
fi

if [ -z "${LE_FQDN}" -a -z "${LE_FQDNS}" ]; then
  echo "ERROR: please specify either LE_FQDN or LE_FQDNS environment variable"
  exit 1
fi

#setup ssl keys
#SSL_KEY=/etc/nginx/ssl/le-key.pem
#SSL_CERT=/etc/nginx/ssl/le-crt.pem
#mkdir -p /etc/nginx/conf.d
#cp -f /etc/nginx/service.conf /etc/nginx/conf.d/service.conf
#sed -i "s|SSL_KEY|${SSL_KEY}|g" /etc/nginx/conf.d/service.conf
#sed -i "s|SSL_CERT|${SSL_CERT}|g" /etc/nginx/conf.d/service.conf

#generate strong dhparams
if [ ! -f /etc/nginx/ssl/dhparams.pem ]; then
    openssl dhparam -out /etc/nginx/ssl/dhparams.pem 2048
    chmod 600 /etc/nginx/ssl/dhparams.pem
fi

#disable ssl configuration and let it run without SSL
mv -v /etc/nginx/conf.d /etc/nginx/conf.d.bak

(
 sleep 5 #give nginx time to start
 echo "start letsencrypt updater"
 while :
 do
	echo "trying to update letsencrypt ..."
    /letsencrypt.sh
    mv -v /etc/nginx/conf.d.bak /etc/nginx/conf.d
    echo "reload nginx with ssl"
    nginx -s reload
    sleep 60d
 done
) &

nginx -g "daemon off;"
