#/bin/bash
FILE=/usr/src/estuary/data/estuary-shuttle.db
if test -f "$FILE"; then
    echo "$FILE exists."
else
    echo "$FILE does not exist."
fi
echo "Hostname: $ESTUARY_HOSTNAME"
if [ -v DEVENV ]; then
    /usr/src/estuary/estuary-shuttle --dev --estuary-api $ESTUARY_HOSTNAME --auth-token $ESTUARY_SHUTTLE_TOKEN --handle $ESTUARY_SHUTTLE_HANDLE
else
    /usr/src/estuary/estuary-shuttle --estuary-api $ESTUARY_HOSTNAME --auth-token $ESTUARY_SHUTTLE_TOKEN --handle $ESTUARY_SHUTTLE_HANDLE
fi
