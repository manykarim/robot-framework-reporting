#!/bin/bash
docker run -d -p 5432:5432 --name=postgres \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=robotframework \
-e POSTGRES_DB=robotframework \
-e PGDATA=/var/lib/postgresql/data/pgdata \
-v "$PWD/postgresql-data:/var/lib/postgresql/data"	\
-v "$PWD/docker/postgres_scripts:/docker-entrypoint-initdb.d" \
--network=robot \
postgres