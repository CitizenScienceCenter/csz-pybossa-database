
#!/bin/bash
#
# script for backing up postgresql database into a file.
# add to crontab for daily execution
# mount open stack volume to backup path to avoid the instance to run out of storage and add to fstab file for automatic mount
# please note that the bind to /var/lib/postgresql/backup as defined in the compose file is the backup path for a possible volume mount

# directory and path inside docker container (mounted to host dir in compose file)
BACKUP_DIR=/var/lib/postgresql/backup
FILENAME=pybossa_pgbackup_
SUFFIX=.sql

# full backup path with today's date
OUTPUT_PATH=${BACKUP_DIR}/${FILENAME}`date +"%Y%m%d"`${SUFFIX}

# create dump of database inside docker container with env variables of container
docker exec -i postgres pg_dump --clean --dbname=pybossa --username=postgres --file=${OUTPUT_PATH}

# show result
echo "${OUTPUT_PATH} was created"
