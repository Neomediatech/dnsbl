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
-- /db/sql
-- /scripts/data
-- /web/nginx/conf
```
This folders must exists prior to start the stack.

## Installation
1. Create folder structure on the host:   
` base_folder="/srv/data/docker/containers/dnsbl-docker-app" ; mkdir -p $base_folder && cd $base_folder ; mkdir -p redis/data db/data db/sql scripts/data web/nginx/conf ; chmod 777 redis/data db/data `   
2. Pull this repo, unpack and move spamikaze folder in scripts/data:   
` cd /srv/data/docker/containers/dnsbl-docker-app/scripts/data ; wget https://github.com/Neomediatech/dnsbl/archive/master.zip ; unzip master.zip ; mv dnsbl-master/spamikaze . `   
3. Move Nginx config in web/nginx/conf:   
` mv dnsbl-master/nginx/nginx.conf web/nginx/conf/ `   
4. Create and compile this four files:   
```
   db/data/db-name.txt    -> database name
   db/data/db-user.txt    -> name for the database user
   db/data/db-dnsbl.pwd   -> password for the database user
   db/data/db-root.pwd    -> password for the mysql/mariadb root user    
```   
5. Move sql files in db/sql:
` mv dnsbl-master/sql/*.sql db/sql/ `   
6. Edit scripts/data/spamikaze/config/config.php to fit database name, user and password.   
16. Cleaning:   
  rm -r dnsbl-master master.zip   

## ToDo
1. web interface
2. docker images
3. docker stack
4. php scripts for
   - delisting requests
   - show records
   - admin maintanance
