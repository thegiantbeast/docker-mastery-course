# Assignment: Manage Multiple Containers

* run a nginx, a mysql, and a httpd (apache) server
* run all of them `--detached` (or `-d`), name them with `--name`
* nginx should listen on `80:80`, httpd on `8080:80`, mysql on `3306:3306`
* when running `mysql`, use the `--environment` option (or `-e`) to pass in `MYSQL_RANDOM_ROOT_PASSWORD=yes`
* use `docker container logs` on mysql to find the random password it created on startup
* Clean it all up with `docker container stop` and `docker container rm`
* use `docker container ls` to ensure everything is correct before and after cleanup