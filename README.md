# AlpineLinux container with Nginx and PHP 8.1
## Usage example
```shell
$ git clone "https://github.com/giuseppe998e/nginx_php81.git"
$ cd ./nginx_php81
$ docker image build -t nginx_php81 .
$ docker run -p 80:80 -p 443:443 -v ./www:/www nginx_php81:latest
```

## PHP info example
```shell
$ git clone "https://github.com/giuseppe998e/nginx_php81.git"
$ docker image build -t nginx_php81 ./nginx_php81
$ docker run --rm -it -p 8080:80 -p 8443:443 nginx_php81:latest
```

