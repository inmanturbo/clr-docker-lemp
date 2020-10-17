GCC=/usr/bin/docker-compose
BASH=/bin/bash
GCCMD=up
GCCARGS=-d

run:
	$(GCC) $(GCCMD) $(GCCARGS)

down:
	$(GCC) down

install:
	$(GCC) run laravel composer create-project --prefer-dist laravel/laravel ./.tmp
	make make_restructure

build:
	$(GCC) build laravel

make_restructure:
	mv ./.tmp/* .
	rm -rf ./.tmp
	
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
	chmod +x ./*.sh