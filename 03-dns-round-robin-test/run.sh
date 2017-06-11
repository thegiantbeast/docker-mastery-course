#!/bin/sh

echo "Creating virtual network"
docker network create round-robin > /dev/null

echo "Starting two containers"
docker container run --rm -d --name es01 --net round-robin --net-alias search elasticsearch:2 > /dev/null
docker container run --rm -d --name es02 --net round-robin --net-alias search elasticsearch:2 > /dev/null

echo "nslookup search (alpine)"
docker container run --rm --net round-robin -it alpine nslookup search

echo "curl search (centos)"
docker container run --rm --net round-robin -i centos bash -c ' \
declare -A dnsArr; \
while [ "${#dnsArr[@]}" -lt 2 ]; \
do \
  dnsEntry="$(curl -s search:9200 | grep \"name\" | awk -F\" '\''{print $4}'\'')"; \
  dnsEntryTrim="${dnsEntry// /}"; \
  [ ! -z "$dnsEntryTrim" ] && echo $dnsEntry && dnsArr[$dnsEntryTrim]=1; \
done \
'

echo "Stopping containers"
docker container stop es01 es02 > /dev/null

echo "Removing virtual network"
docker network remove round-robin > /dev/null