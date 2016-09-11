#!/usr/bin/env bash

function clean_up {
    [ -n "${WM_PID}" ] && kill ${WM_PID}
    [ -z "$1" ] && exit 0 || exit $1
}

cd $(dirname $0)
BASE_DIR=`pwd`
unset WM_PID
FE_DIR="lev-web"
FE_REPO="https://github.com/UKHomeOffice/lev-web.git"

./check-jar.sh

[ -z "${TARGET}" ] && TARGET="https://lev-api-dev.notprod.homeoffice.gov.uk"
[ -z "${PORT}" ] && PORT="8080"
#[[ $TARGET == "https://"* ]] && [ -n "${KEYSTORE}" ] && USE_HTTPS="--https-port \
#    --https-keystore ${KEYSTORE} \
#    --keystore-password ${KEYSTORE_PASSWORD} \
#    --https-truststore ${TRUSTSTORE} \
#    --truststore-password ${TRUSTSTORE_PASSWORD} \
#    --https-require-client-cert "

java -jar ./wiremock-standalone-2.1.11.jar \
    --proxy-all=${TARGET} \
    --port ${PORT} \
    --match-headers="X-Auth-Username,X-Auth-Downstream-Username" \
    --record-mappings \
    --verbose \
    & WM_PID=$!
#    $USE_HTTPS \

if [ -d "${FE_DIR}" ] ; then
    cd "${FE_DIR}"
    git pull
else
    # TODO: remove branch part once merged
    git clone -b "feature/auto-generated-mockapi" "${FE_REPO}" "${FE_DIR}" || clean_up 1
    cd ${FE_DIR}
fi
npm install
npm run test:mockapi

clean_up $?