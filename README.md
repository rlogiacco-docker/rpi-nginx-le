rpi-nginx-le
==============

[![](https://images.microbadger.com/badges/image/rlogiacco/rpi-nginx-le.svg)](https://microbadger.com/images/rlogiacco/rpi-nginx-le) [![](https://images.microbadger.com/badges/version/rlogiacco/rpi-nginx-le.svg)](https://microbadger.com/images/rlogiacco/rpi-nginx-le)

Based on Alpine for ARM this image delivers a [Nginx](https://nginx.org/en/) container with [Letsencrypt](https://letsencrypt.org/) certificate generation and periodic renewal.

[![](https://nginx.org/nginx.png)](https://nginx.org/en/)
[![](https://letsencrypt.org/images/letsencrypt-logo-horizontal.svg)](https://letsencrypt.org/)


# Description
You should run this container on the background and mount the volume with your web content inside.

Includes:

 - Nginx
 - Certbot
 
# Volumes
Exports a volume on `/etc/nginx/ssl` where certificates and dhparams are stored.
You should mount the volume so to store the generated certificate and DH key.

# Ports
Two ports are exposed:

 - 80: default HTTP port
 - 443: default HTTPS port

Remember to map the ports to the docker host on run.


# Run the container using docker
To get the container up and running, run:
 
```
sudo docker run -d -p 8080:80 -p 8443:8443 -v /home/user/le-ssl:/etc/nginx/ssl -v /home/user/www:/var/www -v /home/user/server.conf:/etc/nginx/conf.d/server.conf --env LE_EMAIL=email@example.com --env LE_FQDN=www.example.com rlogiacco/rpi-nginx-le
```

Remember to change:
 - `/home/user/le-ssl` to the directory where you want to store the SSL key, certificate and dhparams
 - `/home/user/www` to the directory hosting your web resources
 - `/home/user/server.conf` to the nginx configuration file you intend to use

### Environment Parameters

The following environment parameters can be set:

 - `LE_FQDN` the domain name to include in the certificate (do not mix with `LE_FQDNS`)
 - `LE_FQDNS` a comma separated list of domain names to include in the certificate (do not mix with `LE_FQDN`)
 - `LE_EMAIL` the email address included into the certificate
 - `LE_TEST` set this to `true` if you wish to generate test certificates rather than fully compliant ones
 


# Links

 - [Source Repository](https://github.com/rlogiacco-docker/rpi-nginx-le)
 - [Dockerfile](https://github.com/rlogiacco-docker/rpi-nginx-le/blob/master/Dockerfile)
 - [DockerHub](https://registry.hub.docker.com/u/rlogiacco/rpi-nginx-le/)
 - [Example server.conf](https://github.com/rlogiacco-docker/rpi-nginx-le/blob/master/example.conf)