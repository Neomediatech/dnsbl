#!/bin/bash

[ -n "${MYSQL_ROOT_PASSWORD}" ] && db_root="${MYSQL_ROOT_PASSWORD}"
[ -n "${MYSQL_ROOT_PASSWORD_FILE}" -a -s "${MYSQL_ROOT_PASSWORD_FILE}" ] && db_root="$(cat "${MYSQL_ROOT_PASSWORD_FILE}")"

[ -n "${MYSQL_USER}" ] && db_user="${MYSQL_USER}"
[ -n "${MYSQL_USER_FILE}" -a -s "${MYSQL_USER_FILE}" ] && db_user="$(cat "${MYSQL_USER_FILE}")"

[ -n "${MYSQL_DATABASE}" ] && db_name="${MYSQL_DATABASE}"
[ -n "${MYSQL_DATABASE_FILE}" -a -s "${MYSQL_DATABASE_FILE}" ] && db_name="$(cat "${MYSQL_DATABASE_FILE}")"

for db in $(cat /docker-entrypoint-initdb.d/*.sql|grep -i "create database"|grep -v "$db_name"|sed 's/\(create\|or replace\|database\|if not exists\|`\)//gi'|awk '{print $1}')
do
  echo "mysql -p$db_root -e GRANT ALL privileges ON \`$db\`.* TO '$db_user'@'%'; FLUSH PRIVILEGES;"
  mysql -p$db_root -e "GRANT ALL privileges ON \`$db\`.* TO '$db_user'@'%'; FLUSH PRIVILEGES;"
done
