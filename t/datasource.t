#!/usr/bin/perl

use strict;
use warnings;

use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Config;

use Data::Dumper;
use Test::More tests=>3;
use Test::Exception;
use File::Find;

my $ds = Finance::HostedTrader::Datasource->new();
isa_ok($ds, 'Finance::HostedTrader::Datasource');

my $res = $ds->getLastClose( symbol => 'GBPCAD');
is_deeply($ds->getLastClose( symbol => 'GBPCAD'), { item0 => "2012-12-14 00:00:00", item1 => 1.5865, symbol => "GBPCAD" }, "getLastClose test 1" );
is_deeply($ds->getLastClose( symbol => 'GBPEUR'), { item0 => "2012-12-14 00:00:00", item1 => 1.2322, symbol => "GBPEUR" }, "getLastClose test 2" );
