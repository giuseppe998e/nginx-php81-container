# AlpineLinux container with Nginx and PHP 8.1
## Usage example
```shell
$ git clone "https://github.com/giuseppe998e/nginx-php81-container.git"
$ cd ./nginx-php81-container
$ docker image build -t nginx_php81 .
$ docker run -p 80:80 -p 443:443 -v ./www:/www nginx_php81:latest
```

## PHP info example
```shell
$ git clone "https://github.com/giuseppe998e/nginx-php81-container.git"
$ docker image build -t nginx_php81 ./nginx-php81-container
$ docker run --rm -it -p 8080:80 -p 8443:443 nginx_php81:latest
```
