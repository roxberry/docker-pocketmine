#Minecraft PE Server
FROM ubuntu:trusty
MAINTAINER  Mark Roxberry <roxberry@outlook.com>

RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php7.0
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php7.0-dev php7.0-enchant php7.0-gd php7.0-gmp php7.0-imap php7.0-interbase php7.0-intl php7.0-ldap php7.0-mcrypt php7.0-readline php7.0-odbc php7.0-pgsql php7.0-pspell php7.0-recode php7.0-snmp php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-sybase php7.0 php7.0-sqlite3 php7.0-opcache php7.0-bz2 php7.0-bcmath php7.0-mbstring php7.0-soap php7.0-xml php7.0-zip

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
