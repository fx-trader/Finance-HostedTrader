#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;
use Data::Dumper;

use Finance::HostedTrader::ExpressionParser;

my $symbol  = 'EURUSD';
my $tf      = '5min';
my $expect;

my $e = Finance::HostedTrader::ExpressionParser->new();

SKIP: {
        skip "Integration tests", 2 unless($ENV{FX_INTEGRATION_TESTS});
adhoc_test('rsi(close,14) > 59', ['2016-09-30 20:50:00'], 'Above');
adhoc_test('crossoverup(rsi(close,14), 59)', ['2016-09-30 20:40:00'], 'Crossover');
adhoc_test('4hourly(macddiff(close,12,26,9) < 0) AND 5minutely(rsi(close,14) < 50)', ['2016-09-30 12:50:00'], 'multiple timeframe (2 expressions)');
adhoc_test('4hourly(close < ema(close,200)) AND 2hourly(rsi(close,14) > 55) AND daily(close < ema(close,20))', ['2016-09-21 22:00:00'], 'multiple timeframe (3 expressions, 3 timeframes)');
adhoc_test('4hourly(close < ema(close,200)) AND 4hourly(rsi(close,14) > 55) AND daily(close < ema(close,20))', ['2016-09-21 22:00:00'], 'multiple timeframe (3 expressions, 2 timeframes)');
}

sub adhoc_test {
    my ($expr, $expected, $desc) = @_;

    my $got = $e->getSignalData( { symbol => $symbol, tf => $tf, numItems => 1, expr => $expr, startPeriod => "2011-10-02 00:00:00", endPeriod => "2016-10-02 00:00:00", maxLoadedItems => 10000  });
    is_deeply($got->{data}->[0], $expected, $desc);
}
