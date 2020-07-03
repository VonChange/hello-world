#!/bin/bash
set -e
#curl -o .env.sh -s -m 10 --connect-timeout 10  "http://service-common.nine:8080/env/param?app=${SPRING_APPLICATION_NAME}&env=${SPRING_PROFILES_ACTIVE}"
#source .env.sh
#env
echo $1
java  $JAVA_OPTS  -jar /$1

exec "$@"