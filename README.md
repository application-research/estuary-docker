# Estuary and Estuary Shuttle Containerized Images Repository

A simple automation script to run a main estuary node with several estuary shuttles.

# Install the following

- docker
- docker hub desktop (optional)

## Component Diagram and How it works

![image](https://user-images.githubusercontent.com/4479171/157354827-9dd254d3-8553-4cc7-9bfe-4dc6b6c1484f.png)

## Run Estuary main
```
cd estuary
./run-main.sh
```
Running the command above will launch a docker image with the estuary node and return an `Auth Token`

## Run Multiple shuttles
```
cd estuary-shuttle
./run-shuttles.sh --num-of-shuttles 3 --estuary-api-key <Auth Token from run-main.sh> --estuary-host localhost:3004
# sample: ./run-shuttles.sh --num-of-shuttles 3 --estuary-api-key EST791bc49e-82d6-4c66-b462-c1c360397475ARY --estuary-host localhost:3004
```

## Test your setup

### Test adding/pinning a new object
```
curl -X POST http://localhost:3004/pinning/pins -d '{ "name": "1882818-2021-nature-videos.zip", "cid": "bafybeidj7c2e3daplalccukbps4eze7473gyshspev76xi4sjfmfkuaofe" }' -H "Content-Type: application/json" -H "Authorization: Bearer <Auth Token>"

```

### Test listing all pinned objects
```
curl -X GET http://localhost:3004/pinning/pins -H "Content-Type: application/json" -H "Authorization: Bearer <Auth Token>"
```