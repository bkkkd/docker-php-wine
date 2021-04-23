build:
	docker build -t docker-php-wine .

run: build
	docker run --rm -p 18080:80 -p 18081:8080 docker-php-wine

shell: build
	docker run --rm -ti -p 18080:8080 -p 18081:8080 -p5900:5900 docker-php-wine bash
