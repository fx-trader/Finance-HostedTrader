#!/usr/bin/perl

use strict;
use warnings;

use Finance::HostedTrader::Datasource;
use Date::Manip;
use Data::Dumper;

my $ds = Finance::HostedTrader::Datasource->new();
my $dbh = $ds->dbh;

my $lookback = 300;

while ($lookback > 0) {
    my $date = UnixDate(ParseDate("sunday $lookback weeks ago at midnight"), "%Y-%m-%d 00:00:00");
    my $data = $dbh->selectrow_arrayref("SELECT label, RSI14 FROM oanda_historical_ALL_604800 WHERE DATETIME = '$date' AND RSI14 IS NOT NULL ORDER BY abs(50-RSI14) DESC LIMIT 1");
    print $date, "\t", join("\t", @$data), "\n";
    $lookback--;
}
