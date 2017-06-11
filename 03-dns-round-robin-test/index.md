# Assignment: DNS Round Robin Test

* create a new virtual network (default bridge driver)
* create two containers from `elasticsearch:2` image
* use `--net-alias search` when creating them to give them an additional DNS name to respond to
* run `alpine nslookup search` with `--net` to see the two containers list for the same DNS name
* run `centos curl -s search:9200` with `--net` multiple times until you see both "name" fields show