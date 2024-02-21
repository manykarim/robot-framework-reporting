#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE DATABASE results;
    CREATE DATABASE robotframework_json;
    CREATE DATABASE testarchiver;
EOSQL