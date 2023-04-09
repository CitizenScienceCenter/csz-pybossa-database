
#!/bin/bash
#
# backup postgresql database into a daily file.
#

# directory and path inside docker container
BACKUP_DIR=/var/lib/postgresql/backup
FILENAME=pybossa_pgbackup_
SUFFIX=.sql

# file name
OUTPUT_PATH=${BACKUP_DIR}/${FILENAME}`date +"%Y%m%d"`${SUFFIX}

# create dump of database inside docker container with env variables of container
docker exec -i postgres pg_dump --clean --dbname=pybossa --username=postgres --file=${OUTPUT_PATH}

# restore database with specific file
#docker exec -i postgres /bin/bash -c "PGPASSWORD=<postgres-pw> psql --host=130.60.24.55 --username=pybossa --dbname=pybossa --file=pybossa-db.bak"

# show result
echo "${OUTPUT_PATH} was created:"
