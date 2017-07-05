#!/bin/sh

username=thegiantbeast
imageName=$username/own-image
containerName=own-image-container

startAndFetchContainer() {
	docker container run --rm --env PORT=80 --name $containerName -d $imageName &> /dev/null
	sleep 5

	echo "Fetching app"
	containerIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $containerName)
	docker container run --rm -it byrnedo/alpine-curl $containerIP

	echo "Stopping containers"
	docker container stop $containerName > /dev/null
}

echo "Building image"
docker image build --no-cache -t $imageName $(dirname $0)/. > /dev/null

echo "Running app container"
startAndFetchContainer

echo "Pushing image"
docker image push $imageName > /dev/null

echo "Removing local image"
docker image rm $imageName > /dev/null

echo "Running app container (from Docker Hub)"
startAndFetchContainer