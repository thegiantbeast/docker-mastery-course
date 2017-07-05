#!/bin/sh

url="http://localhost/jekyll/update/2017/03/05/welcome-to-jekyll.html"

echo "Running jekyll container"
docker container run --rm --name jekyll -p 80:4000 -v $(cd -P "$(dirname $0)" && pwd)/site:/site -d bretfisher/jekyll-serve > /dev/null

echo "Waiting for the service to be available"
cmd="curl --write-out %{http_code} --silent --output /dev/null $url | grep -q '200'"
until eval "$cmd"
do
	sleep 1
done

echo "Editing post content"
dateString=`date +"%d-%m-%Y %H:%M"`
printf "\n## File changed on $dateString" >> $(dirname $0)/site/_posts/2017-03-05-welcome-to-jekyll.markdown

echo "Waiting for the changes to be applied"
cmd="curl -s $url | grep -q 'File changed on $dateString'"
until eval "$cmd"
do
	sleep 1
done

echo "Stopping container"
docker container stop jekyll > /dev/null

echo "Reverting post changes"
git checkout $(dirname $0)/site/_posts/2017-03-05-welcome-to-jekyll.markdown