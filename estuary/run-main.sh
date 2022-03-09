#/bin/bash

ORG_NAME=alvinpai
TAG_NAME=estuary:latest
PORT=3004

docker pull $ORG_NAME/$TAG_NAME

docker network create estuary-local-net

docker run --name "estuary" --net=estuary-local-net -d -p $PORT:$PORT $ORG_NAME/$TAG_NAME 

AUTH_KEY=$(docker exec -ti estuary ./estuary setup)
echo $AUTH_KEY ## key this in on run-shuttles.sh 

containerId=$(docker ps -aqf "name=estuary")
ipAddress=$(docker inspect $containerId | jq -r .[0].NetworkSettings.Networks[].IPAddress)
echo $ipAddress