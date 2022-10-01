#/bin/bash
token_file=/usr/estuary/private/token)
while [ ! -f $token_file ]
do
  echo token file $token_file not found, sleeping 15s then retrying
  sleep 15
done
ESTUARY_TOKEN=$(cat $token_file)



FILE=/usr/src/estuary/data/estuary-shuttle.db
if test -f "$FILE"; then
    echo "$FILE exists."
else
    echo "$FILE does not exist."
fi

sleep 10s
genKey=$(curl -H "Authorization: Bearer $ESTUARY_TOKEN" -X POST http://$ESTUARY_HOSTNAME/admin/shuttle/init)
ESTUARY_SHUTTLE_HANDLE=$(echo $genKey | jq -r '.handle')
ESTUARY_SHUTTLE_TOKEN=$(echo $genKey | jq -r '.token')

echo "Hostname: $ESTUARY_HOSTNAME"
echo "Shuttle Token: $ESTUARY_SHUTTLE_TOKEN"
echo "Shuttle Handle: $ESTUARY_SHUTTLE_HANDLE"
echo "Estuary Token: $ESTUARY_TOKEN"

/usr/src/estuary-shuttle/estuary-shuttle --dev --estuary-api=$ESTUARY_HOSTNAME --auth-token=$ESTUARY_SHUTTLE_TOKEN --handle=$ESTUARY_SHUTTLE_HANDLE
# tail -f /dev/null
