#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;
use Test::Exception;
use Data::Dumper;

use Finance::HostedTrader::ExpressionParser;
my $e = Finance::HostedTrader::ExpressionParser->new();
my $symbol  = 'EURUSD';
my $tf      = 'day';


#TODO: this test doesn't actually test anything yet, so far it has only been used to manually run the statistics code
SKIP: {
    skip "Integration tests", 1 unless($ENV{FX_INTEGRATION_TESTS});

    my $data = $e->getStatisticsData({
        symbol  => $symbol,
        tf      => $tf,
    });

    print Dumper($data);

}
