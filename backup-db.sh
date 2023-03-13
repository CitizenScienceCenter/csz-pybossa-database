
#!/bin/bash
#
# backup postgresql database into a daily file.
#

# directory and path
BACKUP_DIR=./pgbackup
FILENAME=pybossa_pg_backup_
SUFFIX=.sql

# create dir if does not exist
mkdir -p ${BACKUP_DIR}

# file name
OUTPUT_PATH=${BACKUP_DIR}/${FILENAME}`date +"%Y%m%d"`${SUFFIX}

# create dump of database inside docker container with env variables of container
docker exec postgres /bin/bash -c 'pg_dump -U pybossa pybossa' > ${OUTPUT_PATH}

# show the user the result
echo "${OUTPUT_PATH} was created:"
ls -l ${OUTPUT_PATH}
