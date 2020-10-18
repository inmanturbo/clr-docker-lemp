#!make

include make.env
include mariadb.env
include .env

GCC?=/usr/bin/docker-compose
BASH?=/bin/bash
GCCMD?=up
GCCARGS?=-d

run:
	$(GCC) $(GCCMD) $(GCCARGS)

down:
	$(GCC) down

install:
	make make_init
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

publish:
	make make_init
	$(CP) $(CPFLAGS) $(CPSRC) $(CPDEST)

clean:
	rm -rf ./.local/var/lib/mysql/*
	rm -rf ./.local/var/seeds/*
	cp ./.local/etc/.gitignore ./.local/var/lib/mysql/
	cp ./.local/etc/.gitignore ./.local/var/seeds/

reset:
	git reset --hard origin/master
	git clean -f -d
	rm -rf ./vendor
	rm -rf ./bootstrap
	rm -rf ./storage

seed:
	make make_get_seed
	make make_load_seed

build_up:
	make build
	make down
	make clean
	make reset
	make install
	make publish
	make run
	make seed

tear_down:
	make down
	make clean
	make reset

make_init:
	$(GCC) run laravel php -r "file_exists('make.env') || copy('make.env.example', 'make.env');"

make_get_seed:
	make make_init
	cd $(LOCAL_SEEDS_DIR); $(VCS) $(VCSCMD) $(VCFLAGS) $(VCARGS) $(VC_URL)

make_load_seed:
	make make_init
	$(GCC) run db mysql -h db -u $(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DATABASE) < $(MYSQL_SEED_PATH)

make_groups:
	make make_init
	$(BASH) ./groups.sh

make_restructure:
	mv ./.tmp/* .
	rm -rf ./.tmp

