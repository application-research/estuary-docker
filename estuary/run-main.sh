#/bin/bash
ORG_NAME=alvinpai
TAG_NAME=estuary:latest
PORT=3004

docker pull $ORG_NAME/$TAG_NAME
docker run -d -p $PORT:$PORT $ORG_NAME/$TAG_NAME

## Log the API key