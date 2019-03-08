#!/bin/bash

if [ -z "$1" ];
then
  echo "$0 <project_name> <source_dir> <app_name>"
  exit
fi

PROJECT=${1:-slides}
SOURCE_DIR=${2:-.}
APPNAME=${3:-slides}

oc new-project ${PROJECT}
oc new-build nginx --binary=true --name ${APPNAME} -n ${PROJECT}
oc start-build bc/${APPNAME} --from-dir=${SOURCE_DIR}  -n ${PROJECT} --wait=true
oc new-app ${APPNAME} -n ${PROJECT}
oc expose svc ${APPNAME} -n ${PROJECT}
oc get route ${APPNAME} -n ${PROJECT}

