#/bin/bash

function printhelp {
    # $1 = Exit code.
    echo ""
    echo "Run Estuary WWW script parameters:"
    echo "-a|--estuary-api-key      [Mandatory]:  The API key of Estuary"
    echo "-h|--estuary-host         [Mandatory]:  The hostname of Estuary"
    exit $1
}

# Initial checks.
if [ "$1" = "help" -o "$1" = "-help" -o "$1" = "--help" -o "$1" = "h" -o "$1" = "-h" -o "$1" = "--h" ]; then
    printhelp 0
fi
if [ $# -lt 1 ]; then
    echo "Error: Incorrect number of parameters."
    printhelp 1
fi

ESTUARY_HOSTNAME=${ESTUARY_HOSTNAME:-localhost:3004}
API_KEY=${API_KEY:-""} ## get from main 

# Process CLI parameters.
while test $# -gt 0; do
  case "$1" in
    -a|--estuary-api-key)
      shift
      if test $# -gt 0; then
        export API_KEY=$1
        shift
      else
        printhelp 1
      fi
      ;;
    -h|--estuary-host)
      shift
      if test $# -gt 0; then
        export ESTUARY_HOSTNAME=$1
        shift
      else
        printhelp 1
      fi
      ;;
  esac
done

ORG_NAME=alvinpai
TAG_NAME=estuary-www:latest
PORT=4443

docker pull $ORG_NAME/$TAG_NAME
docker run --name "estuary-www" --net=estuary-local-net --dns=8.8.8.8 --env ESTUARY_HOSTNAME=$ESTUARY_HOSTNAME --env ESTUARY_TOKEN=$API_KEY -d -p $PORT:$PORT $ORG_NAME/$TAG_NAME 