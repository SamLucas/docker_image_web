# Dockerfile -  Container servidor web
# V 1.0

FROM ubuntu

RUN apt-get update && apt-get upgrade -y  \
&& export DEBIAN_FRONTEND=noninteractive \
&& apt-get install -y tzdata \
&& ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
&& dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install php php-pear php-fpm php-dev php-zip php-curl \
php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php apache2 wget nano -y

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

WORKDIR /var/www/html/

EXPOSE 80
EXPOSE 443

VOLUME /var/www/html

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

