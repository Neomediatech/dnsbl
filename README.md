# dnsbl
DNSbl service with web interface

## WARNING
This project is work in progress, nothing is working for now (22 sept 2019).

## Introdution
This project aims to fight spam using a [DNSBL service](https://en.wikipedia.org/wiki/DNSBL) through a stack of docker containers.

The project use this folder structure to host persistent data:
```
-  /srv/data/docker/containers/dnsbl-docker-app
-- /redis/data
-- /db/data
-- /scripts/data
-- /web/nginx/conf
```
This folders must exists prior to start the stack.

## Installation
1. Create folder structure on the host:
` base_folder="/srv/data/docker/containers/dnsbl-docker-app" ; mkdir -p $base_folder && cd $base_folder ; mkdir -p redis/data db/data scripts/data web/nginx/conf `
2. Run sql query to populate database, see it on [sql folder](sql/)

## ToDo
1. web interface
2. docker images
3. docker stack
4. php scripts for
   - delisting requests
   - show records
   - admin maintanance
