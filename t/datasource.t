#!/usr/bin/perl

use strict;
use warnings;

use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Config;

use Data::Dumper;
use Test::More tests=>1;
use Test::Exception;
use File::Find;

my $ds = Finance::HostedTrader::Datasource->new();
isa_ok($ds, 'Finance::HostedTrader::Datasource');
