#!/bin/sh
#simple script to export data needed by the tests

set -e

TEST_DATA_DIR=${1:-.}

SYMS="XAGUSD EURUSD USDJPY GBPJPY GBPUSD EURGBP USDCAD"
TFS="300 900 3600 7200 14400 86400"

DBUSER=`fx-show-config.pl db::dbuser`
DBPASSWD=`fx-show-config.pl db::dbpasswd`
DBNAME=`fx-show-config.pl db::dbname`

cd "$(dirname "$0")"

rm -fR testdata
mkdir testdata
cd testdata

for sym in $SYMS; do
  for tf in $TFS; do
    mysql -u$DBUSER -p$DBPASSWD -e "SELECT * FROM ${sym}_${tf} WHERE datetime between '2008-01-01 00:00:00' AND '2012-12-14 00:00:00'" $DBNAME | gzip > ${sym}_${tf}.gz
  done
done

cd ..
tar cPf ${TEST_DATA_DIR}/testdata.tar testdata
rm -fR testdata
