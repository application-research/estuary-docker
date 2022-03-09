#/bin/bash
ESTUARY_HOSTNAME=${ESTUARY_HOSTNAME:-http://localhost:3004}
API_KEY=${API_KEY:-"EST4204a586-93e3-4731-8c77-d43015d164f6ARY"}

curl -H "Authorization: Bearer $API_KEY" -X POST $ESTUARY_HOSTNAME/admin/shuttle/init