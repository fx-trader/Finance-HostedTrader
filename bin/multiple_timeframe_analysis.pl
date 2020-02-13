#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Finance::HostedTrader::Synthetics;
use Finance::HostedTrader::Datasource;

my $instrument = 'XAU_EUR';
my $sql = Finance::HostedTrader::Synthetics::multiple_timeframes(
    instrument => $instrument,
    timeframes => {
        60   => {filter => "< 30"},
        300  => {filter => "< 30"},
        900  => {filter => "< 30"},
        1800 => {filter => "< 30"},
    }
);

my $dbh = Finance::HostedTrader::Datasource->new()->dbh;
my $result = $dbh->selectall_arrayref($sql);

print Dumper($result);
