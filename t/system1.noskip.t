#!/usr/bin/perl

use strict;
use warnings;
use Test::More skip_all => 'Flaky';
use YAML::Tiny;
use File::Basename;

use Finance::HostedTrader::Test::TestSystem;

my $t_path = dirname($0);
my $args;
$args = '--dontSkipDates' if ($0 =~ /noskip/);

my $test = Finance::HostedTrader::Test::TestSystem->new(
                systemName	=> 'trendfollow',
                symbols     =>  {
                                    long  => [],
                                    short => [ 'USDJPY' ],
                                },
                resultsFile => "$t_path/trader/trades.jpy",
                startDate   => '2010-08-18 06:00:00',
                endDate     => '2010-09-17 00:00:00',
                pathToSystems   => "$t_path/systems",
);

$test->run($args);
