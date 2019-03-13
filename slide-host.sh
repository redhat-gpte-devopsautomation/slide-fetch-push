#!/bin/bash

if [ -z "$1" ];
then
  echo "$0 <project_name> <app_name> <source_dir>"
  exit
fi

PROJECT=${1:-slides}
APPNAME=${2:-slides}
SOURCE_DIR=${3:-.}

oc version
oc new-project ${PROJECT}
oc new-build nginx --binary=true --name ${APPNAME} -n ${PROJECT}
oc start-build bc/${APPNAME} --from-dir=${SOURCE_DIR}  -n ${PROJECT} --wait=true
oc new-app ${APPNAME} -n ${PROJECT}
oc expose svc ${APPNAME} -n ${PROJECT}
oc get route ${APPNAME} -n ${PROJECT}


