# Estuary Shuttle Docker Image Repo

Repository to containerized the main estuary node. This is to enable one-click deployment from different cloud service providers using docker.


# Install the following

- docker
- docker hub desktop (optional)

## Build
```
docker build .
```

Get your image id
```
docker images
```
## Tag
```
docker tag  <image> <org>/estuary-shuttle:<version>
```

## Push
```
docker push <org>/estuary-shuttle:<version>
```

## Running your local image
```
docker run <org>/estuary-shuttle:<version>
```