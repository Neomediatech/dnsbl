#!/bin/bash

for file in ca-key.pem  ca.pem  client-cert.pem client-key.pem  client-req.pem  server-cert.pem  server-key.pem  server-req.pem; do
	[ -f /var/lib/mysql/$file ] || missing=1
done
[ -z $missing ] && exit 0

which openssl 1>/dev/null
if [ $? -ne 0 ]; then
	apt update
	apt install -y openssl
fi

cd /var/lib/mysql

OPENSSL_SUBJ="/C=UU/ST=Universe/L=Earth"
OPENSSL_CA="${OPENSSL_SUBJ}/CN=private-CA"
OPENSSL_SERVER="${OPENSSL_SUBJ}/CN=local-server"
OPENSSL_CLIENT="${OPENSSL_SUBJ}/CN=remote-client"

# Generate new CA certificate ca.pem file.
openssl genrsa 2048 > ca-key.pem

# TODO This has interaction that must be automated
openssl req -new -x509 -nodes -days 3600 \
    -subj "${OPENSSL_CA}" \
    -key ca-key.pem -out ca.pem

# Create the server-side certificates
# This has more interaction that must be automated

openssl req -newkey rsa:2048 -days 3600 -nodes \
    -subj "${OPENSSL_SERVER}" \
    -keyout server-key.pem -out server-req.pem
openssl rsa -in server-key.pem -out server-key.pem
openssl x509 -req -in server-req.pem -days 3600 \
    -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out server-cert.pem

# Create the client-side certificates
openssl req -newkey rsa:2048 -days 3600 -nodes \
    -subj "${OPENSSL_CLIENT}" \
    -keyout client-key.pem -out client-req.pem
openssl rsa -in client-key.pem -out client-key.pem
openssl x509 -req -in client-req.pem -days 3600 \
    -CA ca.pem -CAkey ca-key.pem -set_serial 01 -out client-cert.pem

# Verify the certificates are correct
openssl verify -CAfile ca.pem server-cert.pem client-cert.pem
