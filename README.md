## PostgreSQL for pybossa
The database setup is based on postgresql-pgadmin by [awesome-compose](https://github.com/docker/awesome-compose/tree/master/postgresql-pgadmin). 
It includes the following features:
- creation of (consistent) database with automatic initilisation of pybossa user and database.
- backup script for daily backups of pybossa database -> cronjob.
- pgAdmin web interface available at port 5050 (e.g. http://localhost:5050).

Project structure:
```
.
├── .env
├── backup-db.sh
├── compose.yaml
├── initdb
│   └── init-user-db.sh
├── [pgdata] ...
└── README.md
```

## Configuration

### .env
Before deploying this setup, you need to create and configure the following values in the [.env](.env) file.
- POSTGRES_USER
- POSTGRES_PW
- POSTGRES_DB (can be default value)
- PYBOSSA_USER
- PYBOSSA_PW
- PYBOSSA_DB
- PGADMIN_MAIL
- PGADMIN_PW

### Bind Mounts
There are two bind mounts defined in [_compose.yaml_](compose.yaml) 
1. [initdb](initdb) hold the initalisation scripts that are only executed on first container run
2. [pgdata](pgdata) is the permanent store for the postgresql database on the host system and created on first container run. If the dir exists already and contains a functioning database then that database will be used and the initalisation scripts will be skipped
 
## Deploy with docker compose
When deploying this setup, the pgAdmin web interface will be available at port 5050 (e.g. http://localhost:5050).  
On first deployment the init-user-db.sh script will be executed and the [pgdata](pgdata) dir is created as volume mount point for the postgresql database. 
This ensures that the contents of the database are not lost on shutting down the container.

``` shell
$ docker compose up -d
Starting postgres ... done
Starting pgadmin ... done
```
Please note: in case the database initalisation process should be repeated the [pgdata](pgdata) dir has to be deleted first. The init-user-db.sh script is only executed if there exists no database already in pgdata! 

## Add postgres database to pgAdmin
After logging in with your credentials of the .env file, you can add your database to pgAdmin. 
1. Right-click "Servers" in the top-left corner and select "Create" -> "Server..."
2. Name your connection
3. Change to the "Connection" tab and add the connection details:
- Hostname: "postgres" (this would normally be your IP address of the postgres database - however, docker can resolve this container ip by its name)
- Port: "5432"
- Maintenance Database: $POSTGRES_DB (see .env)
- Username: $POSTGRES_USER (see .env)
- Password: $POSTGRES_PW (see .env)
  
## Expected result

Check containers are running:
```
$ docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED             STATUS                 PORTS                                                                                  NAMES
849c5f48f784   postgres:latest                 "docker-entrypoint.s…"   9 minutes ago       Up 9 minutes           0.0.0.0:5432->5432/tcp, :::5432->5432/tcp                                              postgres
d3cde3b455ee   dpage/pgadmin4:latest           "/entrypoint.sh"         9 minutes ago       Up 9 minutes           443/tcp, 0.0.0.0:5050->80/tcp, :::5050->80/tcp                                         pgadmin
```

Stop the containers with
``` shell
$ docker compose down
# To delete all data run:
$ docker compose down -v
```
