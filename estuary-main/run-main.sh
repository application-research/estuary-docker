#/bin/bash

ORG_NAME=alvinpai
TAG_NAME=estuary-main:latest
PORT=3004

docker pull $ORG_NAME/$TAG_NAME

docker network create estuary-local-net

docker run --name "estuary-main" --net=estuary-local-net --dns=8.8.8.8 -d -p $PORT:$PORT $ORG_NAME/$TAG_NAME 

AUTH_KEY=$(docker exec -ti estuary-main ./estuary setup)
echo $AUTH_KEY

containerId=$(docker ps -aqf "name=estuary-main")
ipAddress=$(docker inspect $containerId | jq -r .[0].NetworkSettings.Networks[].IPAddress)
echo $ipAddress