#!/bin/sh

echo "Run CentOS 7, update curl and output its version:"
docker image pull centos:7 > /dev/null
docker container run --rm -i centos:7 <<EOF
yum update curl > /dev/null
curl --version
EOF

echo "\nRun Ubuntu 14.04, update curl and output its version:"
docker image pull ubuntu:14.04 > /dev/null
docker container run --rm -i ubuntu:14.04 <<EOF
apt-get update > /dev/null
apt-get install -y curl &> /dev/null # Ignore TTY errors/warnings
curl --version
EOF