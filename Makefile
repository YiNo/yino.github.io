.PHONY: test

all: run

run:
	hugo server --minify --theme book
sub:
	git submodule update --init
	git submodule update --remote

build:
	hugo -D --minify
