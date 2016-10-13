#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 10;
use Test::Exception;
use Data::Dumper;

BEGIN {
use_ok ('Finance::HostedTrader::Config::Timeframes');
}

my $empty_tfs = Finance::HostedTrader::Config::Timeframes->new(
	'natural' => [],
	);

is_deeply($empty_tfs->natural, [], 'Natural timeframes empty');
is_deeply($empty_tfs->all, [], 'All timeframes empty');

my $tfs = Finance::HostedTrader::Config::Timeframes->new(
	'natural' => [ qw (300 60) ], #Make sure timeframes are unordered to test if the module returns them ordered
	);
isa_ok($tfs,'Finance::HostedTrader::Config::Timeframes');
is($tfs->getTimeframeName($tfs->getTimeframeID('min')), 'min', 'GetTimeframe{ID,Name}');
is_deeply($tfs->natural, [60, 300], 'Natural timeframes sorted');
is_deeply($tfs->all, [60, 300], 'All timeframes sorted');
is_deeply($tfs->all_by_name, [qw/min 5min/], 'All timeframes sorted');


$tfs = Finance::HostedTrader::Config::Timeframes->new(
	'natural' => [ qw (300 60) ],
	);
isa_ok($tfs,'Finance::HostedTrader::Config::Timeframes');


throws_ok {Finance::HostedTrader::Config::Timeframes->new()} qr /Attribute \(natural\) is required/, 'natural timeframes required';

