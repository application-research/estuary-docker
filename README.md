# Estuary Main, Shuttle and WWW docker containers repository

A  automation script to run a main estuary node, frontend and estuary shuttles.

*Work in Progress*

# Install the following

- docker
- docker hub desktop (optional)

## Component Diagram and How it works

![image](https://user-images.githubusercontent.com/4479171/157783874-9186f9d3-512c-4c82-9a85-9cfc8cd65fd3.png)


## Run a Local Estuary, Shuttle and Website with docker-compose

1. Create a local dns mapping in `/etc/hosts`

```
127.0.0.1 estuary-main
```

2. Start up the stack with `docker-compose`
```
docker-compose up
```

3. Navigate to `http://estuary-main:4444`

## Run estuary-main
```
cd estuary-main
./run-main.sh
```
Running the command above will launch a docker image with the estuary node and return an `Auth Token`

## Run multiple estuary-shuttles
```
cd estuary-shuttle
./run-shuttles.sh --num-of-shuttles 3 --estuary-api-key <Auth Token from run-main.sh> --estuary-host estuary-main:3004
# sample: ./run-shuttles.sh --num-of-shuttles 3 --estuary-api-key ESTe2813e65-f177-4192-b601-1e55ca4e930bARY --estuary-host estuary-main:3004
```

The command above will launch three containers with different handles and tokens, which will all connect to the estuary-main via `--estuary-host` flag
## Run estuary frontend 
```
cd estuary-www
./run-www.sh --estuary-api-key <Auth Token from run-main.sh> --estuary-host estuary-main:3004
# sample: ./run-www.sh --estuary-api-key EST6de30581-92bf-4e2d-a218-5233a456baa5ARY --estuary-host estuary-main:3004
```

The frontend will be connected to the estuary-main.
## Test your setup

### Test adding/pinning a new object
```
## estuary-main:3004 or localhost:3004
curl -X POST http://localhost:3004/pinning/pins -d '{ "name": "1882818-2021-nature-videos.zip", "cid": "bafybeidj7c2e3daplalccukbps4eze7473gyshspev76xi4sjfmfkuaofe" }' -H "Content-Type: application/json" -H "Authorization: Bearer <Auth Token>"

```

### Test listing all pinned objects
```
## estuary-main:3004 or localhost:3004
curl -X GET http://localhost:3004/pinning/pins -H "Content-Type: application/json" -H "Authorization: Bearer <Auth Token>"
```

### Test Estuary frontend

Go to [localhost:4444](localhost:4444) and login with your API key.

