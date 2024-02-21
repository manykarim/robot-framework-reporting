#!/bin/bash
docker run -d -p 8086:8086 --name=influx \
-v "$PWD/influx-data:/var/lib/influxdb2" \
-v "$PWD/influx-config:/etc/influxdb2" \
-v "$PWD/docker/influx_scripts:/docker-entrypoint-initdb.d" \
-e DOCKER_INFLUXDB_INIT_MODE=setup \
-e DOCKER_INFLUXDB_INIT_USERNAME=admin \
-e DOCKER_INFLUXDB_INIT_PASSWORD=my-password \
-e DOCKER_INFLUXDB_INIT_ORG=robotframework \
-e DOCKER_INFLUXDB_INIT_BUCKET=results \
-e V1_DB_NAME=v1-db \
-e V1_RP_NAME=v1-rp \
-e V1_AUTH_USERNAME=robot \
-e V1_AUTH_PASSWORD=framework \
-e DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=z2JUbQpw6meZnfKcDdD_yIBgUcIsFUCbXlBAjJILOS7TZu5WSyPx2aFbGEHGUlRjPPr8J4DTXK2jpUDUQeJ4xw== \
--network=robot \
influxdb:latest


