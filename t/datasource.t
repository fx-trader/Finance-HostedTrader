#!/usr/bin/perl

use strict;
use warnings;

use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Config;

use Data::Dumper;
use Test::More tests=>4;
use Test::Exception;
use File::Find;

my $ds = Finance::HostedTrader::Datasource->new();
isa_ok($ds, 'Finance::HostedTrader::Datasource');

my $synth_info = $ds->getSyntheticComponents('GBP', 'CAD');
is_deeply($synth_info, { 'high' => 'high', 'low' => 'low', 'leftop' => 'GBPUSD', 'rightop' => 'USDCAD', 'op' => '*'}, 'GBPCAD synthetic components');

$synth_info = $ds->getSyntheticComponents('CHF', 'JPY');
is_deeply($synth_info, { 'high' => 'low', 'low' => 'high', 'leftop' => 'USDJPY', 'rightop' => 'USDCHF', 'op' => '/'}, 'CHFJPY synthetic components');

$synth_info = $ds->getSyntheticComponents('JPY', 'CHF');
is_deeply($synth_info, { 'high' => 'low', 'low' => 'high', 'leftop' => 'USDCHF', 'rightop' => 'USDJPY', 'op' => '/'}, 'JPYCHF synthetic components');
