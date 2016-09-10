#!/usr/bin/env bash

cd $(dirname $0)

PID_FILE=./wm.pid

if [ -f ${PID_FILE} ] ; then
    WM_PID=`cat ${PID_FILE}`
    kill ${WM_PID}
    rm -f ${PID_FILE}
fi