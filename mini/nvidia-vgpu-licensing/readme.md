https://gitea.publichub.eu/oscar.krause/fastapi-dls

Docker

Docker-Images are available here:

    Docker-Hub: collinwebdesigns/fastapi-dls:latest
    GitLab-Registry: registry.git.collinwebdesigns.de/oscar.krause/fastapi-dls:latest

The images include database drivers for postgres, mariadb and sqlite.

Run this on the Docker-Host

WORKING_DIR=/opt/docker/fastapi-dls/cert
mkdir -p $WORKING_DIR
cd $WORKING_DIR
# create instance private and public key for singing JWT's
openssl genrsa -out $WORKING_DIR/instance.private.pem 2048 
openssl rsa -in $WORKING_DIR/instance.private.pem -outform PEM -pubout -out $WORKING_DIR/instance.public.pem
# create ssl certificate for integrated webserver (uvicorn) - because clients rely on ssl
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout  $WORKING_DIR/webserver.key -out $WORKING_DIR/webserver.crt

Start container

To test if everything is set up properly you can start container as following:

docker volume create dls-db
docker run -e DLS_URL=`hostname -i` -e DLS_PORT=443 -p 443:443 -v $WORKING_DIR:/app/cert -v dls-db:/app/database collinwebdesigns/fastapi-dls:latest

Docker-Compose / Deploy stack

See examples directory for more advanced examples (with reverse proxy usage).

    Adjust REQUIRED variables as needed

version: '3.9'

x-dls-variables: &dls-variables
  TZ: Europe/Berlin # REQUIRED, set your timezone correctly on fastapi-dls AND YOUR CLIENTS !!!
  DLS_URL: localhost # REQUIRED, change to your ip or hostname
  DLS_PORT: 443
  LEASE_EXPIRE_DAYS: 90  # 90 days is maximum
  DATABASE: sqlite:////app/database/db.sqlite
  DEBUG: false

services:
  dls:
    image: collinwebdesigns/fastapi-dls:latest
    restart: always
    environment:
      <<: *dls-variables
    ports:
      - "443:443"
    volumes:
      - /opt/docker/fastapi-dls/cert:/app/cert
      - dls-db:/app/database
    logging:  # optional, for those who do not need logs
      driver: "json-file"
      options:
        max-file: 5
        max-size: 10m
            
volumes:
  dls-db: