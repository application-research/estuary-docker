# Estuary Main Docker Container Orchestration
A repository for handling building, composing, and deploying Estuary using Docker.

The Docker composition will pull the latest images from Docker Hub, and run the Estuary container with:
- A Postgres database
- A NgInx reverse proxy

# Dependencies
- [Docker](https://docs.docker.com/install/)

# Configuration
You will need to edit:
- `.env` to reflect your Docker Hub Org, Estuary Deployment, and Postgres password
- `estuary-reverse-proxy/nginx.conf` to reflect your Estuary Deployment; specifically change all mentions of `localhost:4443` to where your frontend will be deployed
- (optionally) `docker-compose.yml` to reflect any other changes to the composition you might need

# Building
To build the Estuary containers, run the following command:
```
./build-tag-push.sh
```
This will build our Estuary container using the latest version of the Estuary code from the `master` branch.
It will then tag the container with the latest version of the Estuary code and push it to our Docker Hub repository.
It also builds the Reverse Proxy container, which is used to route traffic to the Estuary container.

To run the Docker composition, run the following command:
```
docker-compose up
```
This will pull the latest images from Docker Hub, and run the Estuary container with the Configuration you specified in the `.env` file.

# Deploying

TODO: Add Terraform deployment instructions

