#!/bin/bash

wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.env.example \
 && wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/Dockerfile \
 && wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/docker-compose.yaml \
 && wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/laravel.conf.example \
 && wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/mariadb.env.example \
 && wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/php.ini.example \
 && mkdir -p .local/{etc,home,mnt} \
 && mkdir -p .local/usr/bin \
 && mkdir -p .local/var/{backups,public,seeds} \
 && mkdir -p .local/var/lib/mysql \
 && mkdir -p .local/var/log/nginx \
 && \
 for dir in etc home mnt; \
   do \
     cd .local/${dir}; \
     wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/etc/.gitignore; \
     cd .. ; cd ..; \
 done \
 && \
 for dir in backups public seeds; \
   do \
     cd .local/var/${dir}; \
       wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/etc/.gitignore; \
       cd ..; cd ..; cd ..; \
done \
&& \
cd .local/var/lib/mysql \
&& wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/etc/.gitignore \
&& cd ../../../usr/bin \
&& wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/etc/.gitignore \
&& cd ../../var/log/nginx \
&& wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/etc/.gitignore \
&& cd .. \
    && cd .. \
        && cd .. \
            && cd .. # :-)
