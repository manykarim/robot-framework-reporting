#!/bin/bash
docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=robotframework -e PGDATA=/var/lib/postgresql/data/pgdata -v "$PWD/postgresql-data:/var/lib/postgresql/data"	postgres