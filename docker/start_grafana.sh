#!/bin/bash
docker run -d -p 3000:3000 --name=grafana  --user "$(id -u)"  --volume "$PWD/grafana-data:/var/lib/grafana"  --network=robot grafana/grafana-enterprise