FROM alpine AS builder

ARG AUTH_VERSION

RUN apk --update upgrade && \
    apk add ca-certificates curl jq && \
    apk add --virtual .build-depends \
      file gnupg g++ make \
      boost-dev openssl-dev libsodium-dev lua-dev net-snmp-dev protobuf-dev \
      mariadb-dev postgresql-dev sqlite-dev geoip-dev yaml-cpp-dev && \
    [ -n "$AUTH_VERSION" ] || { curl -sSL 'https://api.github.com/repos/PowerDNS/pdns/tags?per_page=100&page={1,2}' | jq -rs '[.[][]]|map(select(has("name")))|map(select(.name|contains("auth-")))|map(.version=(.name|ltrimstr("auth-")))|map(select(true != (.version|contains("-"))))|map(.version)|"AUTH_VERSION="+.[0]' > /tmp/latest-auth-tag.sh && . /tmp/latest-auth-tag.sh; } && \
    mkdir -v -m 0700 -p /root/.gnupg && \
    curl -RL -O 'https://www.powerdns.com/powerdns-keyblock.asc' && \
    gpg2 --no-options --verbose --keyid-format 0xlong --keyserver-options auto-key-retrieve=true \
        --import *.asc && \
    curl -RL -O "https://downloads.powerdns.com/releases/pdns-${AUTH_VERSION}.tar.bz2{.asc,.sig,}" && \
    gpg2 --no-options --verbose --keyid-format 0xlong --keyserver-options auto-key-retrieve=true \
        --verify *.sig && \
    rm -rf /root/.gnupg *.asc *.sig && \
    tar -xpf "pdns-${AUTH_VERSION}.tar.bz2" && \
    rm -f "pdns-${AUTH_VERSION}.tar.bz2" && \
    ( \
        cd "pdns-${AUTH_VERSION}" && \
        ./configure --sysconfdir=/etc/pdns --mandir=/usr/share/man \
            --enable-libsodium --with-sqlite3 --enable-tools \
            --with-modules='bind gsqlite3' \
            --with-dynmodules='geoip gmysql gpgsql lua pipe random remote' && \
        make -j 2 && \
        make install-strip \
    ) && \
    apk del --purge .build-depends && rm -rf /var/cache/apk/*

FROM alpine

ENV VERSION=4.2.0 \
    BUILD_DATE=2019-09-28 \
    TZ=Europe/Rome \
    MYSQL_AUTOCONF=true \
    MYSQL_HOST="mysql" \
    MYSQL_PORT="3306" \
    MYSQL_USER="root" \
    MYSQL_PASS="root" \
    MYSQL_DB="pdns"
    
LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/dnsbl/docker/images/powerdns \
      org.label-schema.maintainer=Neomediatech

RUN apk --update upgrade && \
    apk add ca-certificates curl less man \
        boost-program_options \
        openssl libsodium lua net-snmp protobuf \
        mariadb-connector-c libpq sqlite-libs \
        geoip yaml-cpp && \
    rm -rf /var/cache/apk/*

ENV PAGER less

RUN addgroup -S pdns && \
    adduser -S -D -G pdns pdns

COPY --from=builder /usr/local/bin /usr/local/bin/
COPY --from=builder /usr/local/sbin /usr/local/sbin/
COPY --from=builder /usr/local/lib/pdns /usr/local/lib/pdns
COPY --from=builder /usr/share/man/man1 /usr/share/man/man1/
COPY --from=builder /usr/local/share/doc/pdns /usr/local/share/doc/pdns
COPY --from=builder /etc/pdns /etc/pdns/

RUN cp -p /etc/pdns/pdns.conf-dist /etc/pdns/pdns.conf && \
    /usr/local/sbin/pdns_server --version || [ $? -eq 99 ]

ADD schema.sql pdns.conf /etc/pdns/
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/usr/local/sbin/pdns_server"]
#CMD ["--help"]

ENTRYPOINT ["/entrypoint.sh"]
