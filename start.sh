#!/usr/bin/env bash

cd $(dirname $0)

if [ ! -e "./wiremock-standalone-2.1.11.jar" ] ; then
    curl -O https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/2.1.11/wiremock-standalone-2.1.11.jar
fi

[ -z "$PORT" ] && PORT="8080"

java -jar ./wiremock-standalone-2.1.11.jar \
    --port $PORT &
echo $! > ./wm.pid