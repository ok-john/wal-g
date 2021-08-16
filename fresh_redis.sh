
#!/bin/bash

declare -a DEPS=( 
                    "pkg-config"
                    "gcc"
                    "make"
                    "autoconf"
                    "autogen"
                    "curl"
                    "wget"
                    "ca-certificates"
                    "openssl"
                    "tcl"
                    "git"
                    "libssl-dev"
                    "libjemalloc-dev"
                    "gnutls-bin"
                    "tclcurl"
                    "acl"
                    "libacl1-dev"
                    "libtool"
                    "dnsmasq-base"
                    "snapd"
                    "libgbtools-dev"
                    "gawk"
                )

apt install -y ${DEPS[@]} 
apt update -y 
apt upgrade -y 
apt autoremove -y

tarfile="redis-stable.tar.gz"
url="http://download.redis.io/redis-stable.tar.gz"
REDISPORT=6379
EXEC=/usr/local/bin/redis-server
CLIEXEC=/usr/local/bin/redis-cli
PIDFILE=/var/run/redis_${REDISPORT}.pid
CONF="/etc/redis/${REDISPORT}.conf"

cd /
rm -rf $tarfile
wget $url
tar -xzf $tarfile
cp /redis-stable/redis.conf /etc/redis/${REDISPORT}.conf
mkdir -p /var/redis
mkdir -p /etc/redis
mkdir -p /var/redis/${REDISPORT}

cd /redis-stable
make distclean
make test
ln -s /redis-stable/src/redis-server /usr/local/bin/redis-server
ln -s /redis-stable/src/redis-cli /usr/local/bin/redis-cli
ln -s /redis-stable/utils/redis_init_script /etc/init.d/redis_${REDISPORT}

update-rc.d redis_${REDISPORT} defaults

echo -e "	You could try: \n\t/etc/init.d/redis_${REDISPORT} start\nOR\n\tredis-server --protected-mode no --daemonize yes"


