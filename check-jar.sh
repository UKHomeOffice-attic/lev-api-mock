#!/usr/bin/env bash

if [ ! -e "./wiremock-standalone-2.1.11.jar" ] ; then
    curl -O https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/2.1.11/wiremock-standalone-2.1.11.jar
fi