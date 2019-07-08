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

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
php composer-setup.php && \
php -r "unlink('composer-setup.php');"

WORKDIR /var/www/html/

EXPOSE 80
EXPOSE 443

VOLUME /var/www/html

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

