#!/bin/bash
set -e

influx config create --config-name ROBOTFRAMEWORK \
  --host-url http://localhost:8086 \
  --org robotframework \
  --token z2JUbQpw6meZnfKcDdD_yIBgUcIsFUCbXlBAjJILOS7TZu5WSyPx2aFbGEHGUlRjPPr8J4DTXK2jpUDUQeJ4xw== \
  --active

influx v1 dbrp update \
  --id 75693aec5d233d49 \
  --rp robot-rp \
  --default

influx v1 dbrp create \
  --bucket-id ${DOCKER_INFLUXDB_INIT_BUCKET_ID} \
  --db ${V1_DB_NAME} \
  --rp ${V1_RP_NAME} \
  --default \
  --org ${DOCKER_INFLUXDB_INIT_ORG}

influx v1 auth create \
  --username ${V1_AUTH_USERNAME} \
  --password ${V1_AUTH_PASSWORD} \
  --write-bucket ${DOCKER_INFLUXDB_INIT_BUCKET_ID} \
  --org ${DOCKER_INFLUXDB_INIT_ORG}