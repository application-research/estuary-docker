#!/bin/bash

# Source our deployment environment (if any)
source .env

# Build, tag, and push our relevant Docker Images

# Build Estuary Main
docker build -t "$ORG_NAME/$ESTUARY_MAIN_TAGNAME" ./estuary-main
docker push "$ORG_NAME/$ESTUARY_MAIN_TAGNAME"

# Build Estuary Reverse Proxy
docker build -t "$ORG_NAME/$ESTUARY_REVERSE_PROXY_TAGNAME" ./estuary-reverse-proxy
docker push "$ORG_NAME/$ESTUARY_REVERSE_PROXY_TAGNAME"