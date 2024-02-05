#!/bin/bash
docker run -d -p 8086:8086 -v "$PWD/influx-data:/var/lib/influxdb2" --network=robot influxdb:latest