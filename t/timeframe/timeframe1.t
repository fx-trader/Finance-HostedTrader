#!/usr/bin/perl

use strict;
use warnings;

use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Config;
use Data::Dumper;
use Test::More tests => 2;
use Test::Exception;

my $cfg= Finance::HostedTrader::Config->new();
my $ds = Finance::HostedTrader::Datasource->new();
my $dbh = $ds->dbh;

my $naturalTFs = $cfg->timeframes->natural;
my $syntheticTFs = $cfg->timeframes->synthetic;


throws_ok {
    $ds->convertOHLCTimeSeries(
                        symbol      => 'SOME',
                        tf_synthetic=> { name => 60, base => 300},
                        start_date  => '0000-00-00',
                        end_date    =>'9999-99-99' ) } qr/Cannot convert to a smaller timeframe/, 'Convert from larger to smaller exception';

throws_ok {
    $ds->convertOHLCTimeSeries(
                        symbol      => 'SOME',
                        tf_synthetic=> { name => -1, base => -2 },
                        start_date  => '0000-00-00',
                        end_date    => '9999-99-99' ) } qr/timeframe not supported \(-1\)/, 'Convert to invalid timeframe exception';
