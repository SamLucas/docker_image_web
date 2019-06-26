# Dockerfile
```
# Dockerfile -  Container servidor web
# V 1.1

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
```

# Instructions for use

This image was created with the goal of having a web server quickly, in this image .htaccess and php are configured and protos for use. ports 80 and 443 are exposed along with the volume in the `/ var / www / html` directory just below you find a hint of how you might be using it.

```
$ sudo docker run -d -p 80:80 -p 443:433 -v  myproject/:/var/www/html/ --name web_server samuellucas/web 
```

configuration suggestions can be forwarded to samuellucas7350@gmail.com.
