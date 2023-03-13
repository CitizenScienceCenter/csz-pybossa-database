#!/usr/bin/env bash
set -e

echo "creating db pybossa with user pybossa and pw  $(cat ${PYBOSSA_PASSWORD_FILE})"

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
	CREATE USER pybossa WITH CREATEDB NOSUPERUSER PASSWORD '$(cat ${PYBOSSA_PASSWORD_FILE})';
	CREATE DATABASE pybossa WITH OWNER pybossa;
EOSQL
echo "finished creating db"
