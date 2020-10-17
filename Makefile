GCC=/usr/bin/docker-compose
BASH=/bin/bash
GCCMD=up
GCCARGS=-d

run:
	$(GCC) $(GCCMD) $(GCCARGS)

down:
	$(GCC) down

install:
	composer create-project --prefer-dist laravel/laravel
	make make_restructure

build:
	$(GCC) build laravel

make_restructure:
	mv ./laravel/* .
	rm -rf ./laravel

clean:
	sudo rm -rf ./.local/var/lib/mysql/*
	sudo cp ./.local/etc/.gitignore ./.local/var/lib/mysql/

reset:
	git reset --hard 
	git clean -f -d

groups:
	make make_init
	$(BASH) ./groups.sh

make_init:
	chmod +x ./*.sh