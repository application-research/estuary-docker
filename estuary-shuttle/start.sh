#/bin/bash

sleep 20s
ESTUARY_TOKEN=$(cat /usr/estuary/private/token)
genKey=$(curl -H "Authorization: Bearer $ESTUARY_TOKEN" -X POST http://$ESTUARY_HOSTNAME/admin/shuttle/init)
ESTUARY_SHUTTLE_HANDLE=$(echo $genKey | jq -r '.handle')
ESTUARY_SHUTTLE_TOKEN=$(echo $genKey | jq -r '.token')

echo "Hostname: $ESTUARY_HOSTNAME"
echo "Shuttle Token: $ESTUARY_SHUTTLE_TOKEN"
echo "Shuttle Handle: $ESTUARY_SHUTTLE_HANDLE"
echo "Estuary Token: $ESTUARY_TOKEN"

export LD_LIBRARY_PATH=/usr/lib/aarch64-linux-gnu/
/usr/estuary-bin/estuary-shuttle --dev --estuary-api=$ESTUARY_HOSTNAME --auth-token=$ESTUARY_SHUTTLE_TOKEN --handle=$ESTUARY_SHUTTLE_HANDLE
# tail -f /dev/null
