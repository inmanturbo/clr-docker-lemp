GCC=/usr/bin/docker-compose
BASH=/bin/bash
GCCMD=up
GCCARGS=-d

run:
	$(GCC) $(GCCMD) $(GCCARGS)

down:
	$(GCC) down

install:
	composer create-project --prefer-dist laravel/laravel ./.tmp
	make make_restructure

build:
	$(GCC) build laravel

make_restructure:
	mv ./laravel/* .
	rm -rf ./tmp
	
clean:
	sudo rm -rf ./.local/var/lib/mysql/*
	sudo cp ./.local/etc/.gitignore ./.local/var/lib/mysql/

reset:
	git reset --hard 
	git clean -f -d
	rm -rf ./vendor

groups:
	make make_init
	$(BASH) ./groups.sh

make_init:
	chmod +x ./*.sh