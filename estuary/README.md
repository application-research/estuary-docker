# Estuary Main Docker Image Repo

Repository to containerized the main estuary node. This is to enable one-click deployment from different cloud service providers using docker.

# Install the following

- docker
- docker hub desktop (optional)

# Single command run using docker
```
./one-command-run.sh
```

# Build, Tag, Push (Optional) and Run
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
docker tag  <image> <org>/estuary:<version>
```

## Push
```
docker push <org>/estuary:<version>
```

## Running your local image
```
docker run <org>/estuary:<version>
```