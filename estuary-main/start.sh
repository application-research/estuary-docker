#/bin/bash
FULLNODE_API_INFO=$FULLNODE_API_INFO
ESTUARY_HOSTNAME=$ESTUARY_HOSTNAME

if [ -z "$FULLNODE_API_INFO" ]; then
    echo "FULLNODE_API_INFO is empty, use default value"
    FULLNODE_API_INFO="wss://api.chain.love"
fi

echo "HOSTNAME: $ESTUARY_HOSTNAME"
echo "FULLNODE_API_INFO: $FULLNODE_API_INFO"

AUTH_FILE=/usr/src/estuary/data/setup.log
FILE=/usr/src/estuary/data/estuary.db
if test -f "$FILE"; then
    echo "$FILE exists."
    /usr/src/estuary/estuary --hostname $ESTUARY_HOSTNAME
else
    echo "$FILE does not exist."
    mkdir -p /usr/src/estuary/data
    AUTH_KEY=$(/usr/src/estuary/estuary setup | grep Token | cut -d ' ' -f 3)
    echo $AUTH_KEY
    echo $AUTH_KEY > /usr/estuary/private/token
    cat /usr/estuary/private/token
fi

#sed -i "s|PESTUARY_TOKEN|$ESTUARY_TOKEN|g" ./env
#/usr/src/estuary/estuary

/usr/src/estuary/estuary $ESTUARY_HOSTNAME