#!/bin/sh

echo "Starting nginx, httpd and mysql containers."

docker container run -d -p 80:80 --name ws-nginx nginx
docker container run -d -p 8080:80 --name ws-httpd httpd
docker container run -d -p 3306:3306 --name db-mysql -e MYSQL_RANDOM_ROOT_PASSWORD=yes mysql

docker container logs -f db-mysql 2>&1 | awk '/GENERATED/ {print; exit 0}'

echo "Showing running containers."

docker container ls

echo "Stopping containers."

docker container stop ws-nginx ws-httpd db-mysql

echo "Removing containers."

docker container rm ws-nginx ws-httpd db-mysql

echo "Showing running containers."

docker container ls

echo "All done."
