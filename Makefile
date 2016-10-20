
default:
	docker build -t go-static:latest .

install:
	cp go-static /usr/local/bin/
