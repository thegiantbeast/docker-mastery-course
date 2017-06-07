# Assignment: CLI App Testing

* use different Linux distro containers to check `curl` cli tool version
* start both `centos:7` and `ubuntu:14.04` using `-it`
* learn the `docker container --rm` option so you can save cleanup
* ensure curl is installed and on latest version for that distro
 * ubuntu: `apt-get update && apt-get install curl`
 * centos: `yum update curl`
* check `curl --version`