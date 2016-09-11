#!/usr/bin/env bash

cd $(dirname $0)

./check-jar.sh

[ -z "$PORT" ] && PORT="8080"

java -jar ./wiremock-standalone-2.1.11.jar \
    --port $PORT &
echo $! > ./wm.pid