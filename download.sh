#!/bin/bash

wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.env.example
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/Dockerfile
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/docker-compose.yaml
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/laravel.conf.example
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/laravel.env.example
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/make.env.example
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/mariadb.env.example
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/php.ini.example

mkdir -p .local/
cd .local/

wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/etc/.gitignore
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/home/.gitignore
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/mnt/.gitignore
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/usr/bin/.gitignore
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/var/backups/.gitignore
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/var/lib/mysql/.gitignore
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/var/log/nginx/.gitignore
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/var/public/.gitignore
wget https://raw.githubusercontent.com/inmanturbo/clr-docker-lemp/master/.local/var/seeds/.gitignore