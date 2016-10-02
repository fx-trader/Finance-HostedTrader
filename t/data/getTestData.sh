#!/bin/sh
#simple script to export data needed by the tests

set -eu

TEST_DATA_DIR=${1:-.}

SYMS="XAUUSD XAGUSD AUDJPY EURUSD USDJPY GBPJPY GBPUSD EURGBP USDCAD"
TFS="300"

DBUSER=`fx-show-config.pl db::dbuser`
DBPASSWD=`fx-show-config.pl db::dbpasswd`
DBNAME=`fx-show-config.pl db::dbname`

cd "$(dirname "$0")"

rm -vfR testdata
mkdir -v testdata
cd testdata

for sym in $SYMS; do
  for tf in $TFS; do
    echo Dumping $sym $tf
    mysql -h fxdata -u$DBUSER -p$DBPASSWD -e "SELECT * FROM ${sym}_${tf} WHERE datetime between '2016-02-26 00:00:00' AND '2016-10-02 00:00:00'" $DBNAME | gzip > ${sym}_${tf}.gz
  done
done

cd ..
tar cvPf ${TEST_DATA_DIR}/testdata.tar testdata
rm -fvR testdata
