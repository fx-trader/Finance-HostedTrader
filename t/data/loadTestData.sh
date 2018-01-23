#!/bin/sh
#simple script to import data needed by the tests

set -eu

TEST_DATA_DIR=${1:-.}

# As written, this can only run inside the container, and the container needs to have the mariadb-client package installed (apt-get update && apt-get install mariadb-client)

# Could drop database here, recreate it, then load test dataset, ie:
# docker run --rm --link fxdata:mysql mariadb sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" -e "drop database fxdata"'
# docker run --rm --link fxdata::fxdata -v /root/fx/cfg:etc/fxtrader fxtrader/finance-hostedtrader 'fx-create-db-schema.pl | fx-db-client.pl'
# Problem with this approach is that data gets old over time, and it's hard to compare visually against charts, because i have no charting capability, and the web charts will tend to have fresh recent data

DBUSER=`fx-show-config.pl db::dbuser`
DBPASSWD=`fx-show-config.pl db::dbpasswd`
DBNAME=`fx-show-config.pl db::dbname`
DBHOST=`fx-show-config.pl db::dbhost`

rm -vfR testdata
tar vxf ${TEST_DATA_DIR}/testdata.tar
cd testdata

for file in *gz; do
    gunzip -v $file
done

mysqlimport -h $DBHOST -v --ignore --ignore-lines=1 --local --fields-terminated-by='\t' --lines-terminated-by='\n' -s -u$DBUSER -p$DBPASSWD $DBNAME *_*
cd ..
rm -vfR testdata
