all: build

build:
	parrot-nqp setup.nqp build

test: build
	parrot-nqp setup.nqp test

install: build
	parrot-nqp setup.nqp install

clean:
	parrot-nqp setup.nqp clean
