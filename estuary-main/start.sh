#!/bin/bash

#This is the script that is run when the docker container is started.
# Please see the Dockerfile for more information on the context of this script.

# Here for notation purposes
# The Workdir for the container
WORKDIR=/app

# Log our Deployment Config
echo "WORKDIR: $WORKDIR"
echo "HOSTNAME: $ESTUARY_MAIN_HOSTNAME"
echo "FRONTEND: $ESTUARY_WWW_HOSTNAME"
echo "FULLNODE_API: $FULLNODE_API"

# Log our Postgres DB Connection
echo "DB_TYPE: $DB_TYPE"
echo "DB_HOST: $DB_HOST"
echo "DB_PORT: $DB_PORT"
echo "DB_USER: $DB_USER"
echo "DB_PASSWORD: $DB_PASSWORD"
echo "DB_NAME: $DB_NAME"

# Define a Database Connection String
# This one is for Postgres!
DB_CONN_STRING="$DB_TYPE=$DB_TYPE://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME"
echo "DB_CONN_STRING: $DB_CONN_STRING"

# Where our Estuary container stores its Blockstore
# We will configure a docker Volume for this in the compose stack
DATA_DIR=/mnt/blockstore
# Where our Estuary container stores its config
PRIVATE_DIR=/mnt/private

# We'll take PRIVATE_DIR existing as a test of whether or not we've initialized this Container
if test ! -d "$PRIVATE_DIR"; then
  echo "Initializing Estuary Node Credentials..."

  # This is needed to make sure we dont get 'too many open files' errors
  ulimit -n 100000 # This needs to be reaaally big for PostGres

  # Initialize our Mounts
  mkdir -p $DATA_DIR
  mkdir -p $PRIVATE_DIR

  # setup our node in the container
  ESTUARY_TOKEN=$(/app/estuary setup --database="$DB_CONN_STRING" --username=admin | grep Token | cut -d ' ' -f 3)
  # Check if we have a token
  if [ -z "$ESTUARY_TOKEN" ]; then
    echo "Failed to get Estuary Token"
    exit 1
  fi
  # Store our Admin Token
  echo "$ESTUARY_TOKEN" > $PRIVATE_DIR/token
  echo "Estuary Admin Key: $ESTUARY_TOKEN"
fi

# Start the Estuary node
# --database: is the connection string for our Postgres or MySQL DB. We use Postgres here.
# --datadir: Where the Node stores data
# --front-end-hostname: Where the front end is being served
echo "Starting Estuary Node..."
/app/estuary \
  --database="$DB_CONN_STRING" \
  --datadir="$DATA_DIR" \
  --front-end-hostname="$ESTUARY_WWW_HOSTNAME" \
  --logging=true