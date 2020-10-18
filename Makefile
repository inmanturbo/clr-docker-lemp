#!make

-include make.env
-include mariadb.env
-include .env

CP?=/usr/bin/cp
CPFLAGS?=-prv

GCC?=/usr/bin/docker-compose
BASH?=/bin/bash
GCCMD?=up
GCCARGS?=-d

run:
	make make_init
	$(GCC) $(GCCMD) $(GCCARGS)

down:
	$(GCC) down

install:
	make make_init
	$(GCC) run laravel composer create-project --prefer-dist laravel/laravel ./.tmp
	make make_restructure

build:
	make make_init
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
	make make_init
	make build
	make down
	make clean
	make reset
	make install
	make publish
	make run
	make seed

tear_down:
	make make_init
	make down
	make clean
	make reset

make_init:
	$(CP) $(CPFLAGS) .env.example .env
	$(CP) $(CPFLAGS) make.env.example make.env
	$(CP) $(CPFLAGS) laravel.env.example laravel.env
	$(CP) $(CPFLAGS) mariadb.env.example mariadb.env

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

