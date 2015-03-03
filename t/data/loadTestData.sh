#!/bin/sh
#simple script to import data needed by the tests

set -e

TEST_DATA_DIR=${1:-.}

DBUSER=`fx-show-config.pl db::dbuser`
DBPASSWD=`fx-show-config.pl db::dbpasswd`
DBNAME=`fx-show-config.pl db::dbname`

rm -vfR testdata
tar vxf ${TEST_DATA_DIR}/testdata.tar
cd testdata

for file in *gz; do
    gunzip -v $file
done

#TODO Hardcoded mysql credentials
mysqlimport -v --ignore --ignore-lines=1 --local --fields-terminated-by='\t' --lines-terminated-by='\n' -s -u$DBUSER -p$DBPASSWD $DBNAME *_*
cd ..
rm -vfR testdata
