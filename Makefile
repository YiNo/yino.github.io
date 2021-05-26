.PHONY: test

all: run

run:
	hugo server --minify --theme book
mod:
	git submodule update --init
	git submodule update --remote

build:
	hugo -D --minify
	
install:
	git submodule update --init
	git submodule update --remote
	hugo -D --minify
	
