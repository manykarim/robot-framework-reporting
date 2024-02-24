#!/bin/bash
docker run -d -p 3000:3000 --name=grafana \
--user "$(id -u)" \
--volume "$PWD/grafana-data:/var/lib/grafana" \
-e GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS=volkovlabs-variable-panel \
--network=robot \
grafana/grafana-enterprise