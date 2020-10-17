#!make
GCC?=/usr/bin/docker-compose
BASH?=/bin/bash
GCCMD?=up
GCFLAGS?=-d

include make.env

run:
	$(GCC) $(GCCMD) $(GCCARGS)

down:
	$(GCC) down

install:
	$(GCC) run laravel composer create-project --prefer-dist laravel/laravel ./.tmp
	make make_restructure
	$(GCC) run laravel php -r "file_exists('mariadb.env') || copy('mariadb.env.example', 'mariadb.env');"
	$(GCC) run laravel php -r "file_exists('laravel.env') || copy('laravel.env.example', 'laravel.env');"
	$(GCC) run laravel php -r "file_exists('laravel.conf') || copy('laravel.conf.example', 'laravel.conf');"
	$(GCC) run laravel php -r "file_exists('php.ini') || copy('php.ini.example', 'php.ini');"

build:
	$(GCC) build laravel
	$(GCC) build nginx
	$(GCC) build db

make_restructure:
	mv ./.tmp/* .
	rm -rf ./.tmp

publish:
	make make_init
	$(CP) $(CPFLAGS) $(CPSRC) $(CPDEST)

clean:
	rm -rf ./.local/var/lib/mysql/*
	cp ./.local/etc/.gitignore ./.local/var/lib/mysql/

reset:
	git reset --hard origin/master
	git clean -f -d
	rm -rf ./vendor
	rm -rf ./bootstrap
	rm -rf ./storage


groups:
	make make_init
	$(BASH) ./groups.sh

make_init:
	$(GCC) run laravel php -r "file_exists('make.env') || copy('make.env.example', 'make.env');"
	chmod +x ./*.sh