#/bin/bash

ORG_NAME=alvinpai
TAG_NAME=$ORG_NAME/estuary-shuttle:latest

# build
docker build . -t $TAG_NAME
docker push $TAG_NAME