#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;
use Test::Exception;
use Data::Dumper;

use Finance::HostedTrader::ExpressionParser;

my $symbol  = 'EURUSD';
my $tf      = 'day';
my $expect;

my $e = Finance::HostedTrader::ExpressionParser->new();

SKIP: {
        skip "Integration tests", 2 unless($ENV{FX_INTEGRATION_TESTS});
adhoc_test('rsi(close,14) > 59', ['2012-03-29 21:00:00'], 'Above');
adhoc_test('crossoverup(rsi(close,14), 59)', ['2012-03-29 21:00:00'], 'Crossover');
}

sub adhoc_test {
    my ($expr, $expected, $desc) = @_;

    my $got = $e->getSignalData( { symbol => $symbol, tf => $tf, numItems => 1, expr => $expr, startPeriod => "2011-10-02 00:00:00", endPeriod => "2012-05-31 23:00:00", maxLoadedItems => 125  });
    is_deeply($got->[0], $expected, $desc);
}
