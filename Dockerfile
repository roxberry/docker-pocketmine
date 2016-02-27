#Minecraft PE Server
FROM ubuntu:trusty
MAINTAINER  Mark Roxberry <roxberry@outlook.com>

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php-7.0
sudo apt-get update
sudo apt-get install libapache2-mod-php7.0 php7.0-fpm php7.0-common php7.0-cli php-pear php7.0-curl php7.0-gd php7.0-gmp php7.0-intl php7.0-imap php7.0-json php7.0-ldap php7.0-mcrypt php7.0-mysql php7.0-psphp7.0-readline php7.0-tidy php7.0-xmlrpc php7.0-xsl
sudo apt-get --purge autoremove

#Setup enviroment variables
ENV CNAME="pocketmine"

#Update container
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y vim sudo wget perl gcc g++ make automake libtool autoconf m4 gcc-multilib
RUN DEBIAN_FRONTEND=noninteractive apt-get clean

#Stage Files
COPY server.properties /tmp/server.properties
COPY start.sh /start.sh
RUN chmod 755 /start.sh

#Setup User
RUN useradd -d /data -s /bin/false --uid 1000 minecraft

#Setup container
EXPOSE 19132
VOLUME ["/data"]

#Start Pocketmine
WORKDIR /data
CMD ["/start.sh"]
