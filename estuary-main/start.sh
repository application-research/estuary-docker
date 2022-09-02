#!/bin/bash

#This is the script that is run when the docker container is started.
# Please see the Dockerfile for more information on the context of this script.
WORKDIR=/app

echo "WORKDIR: $WORKDIR"
echo "HOSTNAME: $ESTUARY_MAIN_HOSTNAME"
echo "FRONTEND: $ESTUARY_WWW_HOSTNAME"
echo "FULLNODE_API_INFO: $FULLNODE_API_INFO"

DB_DIR=$WORKDIR/data/
DB_FILE=$DB_DIR/estuary.db
if test ! -f "$DB_FILE"; then
  echo "Initializng Estuary Node"

  # This is needed to make sure we dont get 'too many open files' errors
  ulimit -n 10000

  # Initialize directories for our data and secrets
  mkdir -p "$DB_DIR"
  mkdir -p "$WORKDIR"/private

  # TODO: Implement Postgres
  ESTUARY_TOKEN=$("$WORKDIR"/estuary setup --username=admin | grep Token | cut -d ' ' -f 3)
  echo "$ESTUARY_TOKEN" > $WORKDIR/private/token
  echo "Estuary Admin Key: $ESTUARY_TOKEN"
fi

# Start the Estuary node
# --datadir : Where the Node stores data
# --front-end-hostname: Where the front end is being served

$WORKDIR/estuary \
  --datadir="$DB_DIR" \
  --front-end-hostname="$ESTUARY_WWW_HOSTNAME"