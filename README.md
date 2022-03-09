# Estuary and Estuary Shuttle Containerized Images Repository

A simple automation script to run a main estuary node, frontend and estuary shuttles for development purposes.

# Install the following

- docker
- docker hub desktop (optional)

## Component Diagram and How it works

![image](https://user-images.githubusercontent.com/4479171/157367382-d7e460c4-0c82-4a71-af5d-b5e1810d09c3.png)


## Run estuary-main
```
cd estuary
./run-main.sh
```
Running the command above will launch a docker image with the estuary node and return an `Auth Token`

## Run multiple estuary-shuttles
```
cd estuary-shuttle
./run-shuttles.sh --num-of-shuttles 3 --estuary-api-key <Auth Token from run-main.sh> --estuary-host localhost:3004
# sample: ./run-shuttles.sh --num-of-shuttles 3 --estuary-api-key EST890be289-a6fe-4fb5-a402-c2b895c644a0ARY --estuary-host localhost:3004
```

## Run estuary frontend 
```
cd estuary-www
./run-www.sh --estuary-api-key <Auth Token from run-main.sh> --estuary-host localhost:3004
# sample: ./run-www.sh --estuary-api-key EST890be289-a6fe-4fb5-a402-c2b895c644a0ARY --estuary-host localhost:3004
```

Go to [localhost:4444](localhost:4444)

## Test your setup

### Test adding/pinning a new object
```
curl -X POST http://localhost:3004/pinning/pins -d '{ "name": "1882818-2021-nature-videos.zip", "cid": "bafybeidj7c2e3daplalccukbps4eze7473gyshspev76xi4sjfmfkuaofe" }' -H "Content-Type: application/json" -H "Authorization: Bearer <Auth Token>"

```

### Test listing all pinned objects
```
curl -X GET http://localhost:3004/pinning/pins -H "Content-Type: application/json" -H "Authorization: Bearer <Auth Token>"
```
