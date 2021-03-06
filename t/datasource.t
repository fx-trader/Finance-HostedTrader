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

SKIP: {
    skip "Integration tests", 2 unless($ENV{FX_INTEGRATION_TESTS});
my $res = $ds->getLastClose( instrument => 'GBPCAD');
is_deeply($ds->getLastClose( instrument => 'GBPCAD'), { item0 => "2012-12-14 00:00:00", item1 => "1.5865", instrument => "GBPCAD" }, "getLastClose test 1" );
is_deeply($ds->getLastClose( instrument => 'GBPEUR'), { item0 => "2012-12-14 00:00:00", item1 => "1.2320", instrument => "GBPEUR" }, "getLastClose test 2" );
}
