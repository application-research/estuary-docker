#/bin/bash

ORG_NAME=alvinpai
TAG_NAME=estuary:latest
PORT=3004

docker pull $ORG_NAME/$TAG_NAME
docker run --name "estuary" -d -p $PORT:$PORT $ORG_NAME/$TAG_NAME 

AUTH_KEY=$(docker exec -ti estuary ./estuary setup)
echo $AUTH_KEY ## key this in on run-shuttles.sh 