#!/usr/bin/env bash
set -e

echo "pybossa needs a seperated postgres database and user"
echo "initializing pybossa database and user..."
psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
	CREATE USER pybossa WITH CREATEDB NOSUPERUSER PASSWORD '$(cat ${PYBOSSA_PASSWORD_FILE})';
	CREATE DATABASE pybossa WITH OWNER pybossa TEMPLATE template0;
EOSQL
echo "...done"

# psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
# 	CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'testpassword' LOGIN;
# EOSQL

#'$(cat ${PYBOSSA_PASSWORD_FILE})'

