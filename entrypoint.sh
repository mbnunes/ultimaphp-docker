#!/bin/bash

cd /ultimaphp/tools/Mongo_Database

mongoimport --host=${MONGODB_HOST}:${MONGODB_PORT}   -u=${MONGODB_USER} -p=${MONGODB_PASS} --db=${UPHP_DB_NAME} --type=json --file=accounts.json
mongoimport --host=${MONGODB_HOST}:${MONGODB_PORT}   -u=${MONGODB_USER} -p=${MONGODB_PASS} --db=${UPHP_DB_NAME} --type=json --file=objects.json
mongoimport --host=${MONGODB_HOST}:${MONGODB_PORT}   -u=${MONGODB_USER} -p=${MONGODB_PASS} --db=${UPHP_DB_NAME} --type=json --file=players.json
mongoimport --host=${MONGODB_HOST}:${MONGODB_PORT}   -u=${MONGODB_USER} -p=${MONGODB_PASS} --db=${UPHP_DB_NAME} --type=json --file=server_starting_locations.json

cd /ultimaphp

sed -i -- 's/ip=127.0.0.1/ip=0.0.0.0/g' ultimaphp.ini
sed -i -- 's/host=127.0.0.1/host="${MONGODB_HOST}"/g' ultimaphp.ini

php startserver.php