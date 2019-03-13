# Dockerfile -  Container servidor web
# V 1.0

# selecionando o sistema da imagem
FROM ubuntu

# atualizando o container
RUN apt-get update && apt-get upgrade -y

# configurando o tzdata
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata 

# instalando o php
RUN apt-get install php php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-xml libapache2-mod-php -y

# instalando o apache2
RUN apt-get install apache2 -y

# instalando outros programas 
RUN apt-get install nmap git wget nano sudo -y

# definindo pasta home do container
WORKDIR /var/www/html/

# configurando o .htaccess
RUN rm /etc/apache2/sites-available/000-default.conf
RUN git clone https://github.com/SamLucas/Arquivos.git
RUN mv Arquivos/000-default.conf /etc/apache2/sites-available/

# habilitando o mod_rewrite
RUN a2enmod rewrite

# criando usuario do container 
RUN useradd web -ms /bin/bash -G sudo

# setando usuario do container
USER web
