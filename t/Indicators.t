#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 62;
use Test::Exception;
use Data::Dumper;

use Finance::HostedTrader::ExpressionParser;

my $symbol  = 'EURUSD';
my $tf      = 'day';
my $expect;

my $e = Finance::HostedTrader::ExpressionParser->new();
throws_ok { $e->getIndicatorData( { symbol => $symbol, tf => $tf, fields => 'rsi(close,21)' }) } qr/Unknown column 'datetime' in 'order clause'/, "No datetime in expression";
throws_ok { $e->getIndicatorData( { symbol => $symbol, tf => 'badtf', numItems => 1, fields => 'rsi(close,21)' }) } qr/Could not understand timeframe badtf/, "Invalid timeframe";

testIndicator('ema', 'close,21', '1.2712', 'close', 'close,21,22', 'bad,21');
testIndicator('sma', 'close,21', '1.2776', 'close', 'close,21,22', 'bad,21');
testIndicator('rsi', 'close,21', '29.67', 'close', 'close,21,22', 'bad,21');
testIndicator('max', 'close,21', '1.3239', 'close', 'close,21,22', 'bad,21');
testIndicator('min', 'close,21', '1.2367', 'close', 'close,21,22', 'bad,21');
testIndicator('tr', '', '0.0171', undef, '14', 'bad,21');
testIndicator('atr', '14', '0.0117', '', '14,21', 'close');
testIndicator('previous', 'close,21', '1.3258', 'close', 'close,21,22', 'bad,21');
testIndicator('bolhigh', 'close,21,2', '1.3388', 'close', 'close,21,22,2', 'bad,21,2');
testIndicator('bollow', 'close,21,2', '1.2164', 'close', 'close,21,22,2', 'bad,21,2');
testIndicator('trend', 'close,21', '-1.11', 'close', 'close,21,22', 'bad,21');
testIndicator('macd', 'close,12,26,9', '-0.0186', 'close', 'close,12,26,9,1', 'bad,12,26,9');
testIndicator('macdsig', 'close,12,26,9', '-0.0154', 'close', 'close,12,26,9,1', 'bad,12,26,9');
testIndicator('abs', '10-20', '10', '', 'close,12', 'bad');

adhoc_test('datetime,ema(rsi(close,21),21)', '34.5185', 'recursive');

adhoc_test('datetime,rsi(close,21) + ema(close,21)', '30.9412', 'expr + expr');
adhoc_test('datetime,rsi(close,21) / ema(close,21)', '23.34015104', 'expr / expr');
adhoc_test('datetime,(2+3)*4', '20', 'operator precedence simple');
adhoc_test('datetime,(2+ema(close,21))*atr(21)', '0.0366', 'operator precedence expr');

sub testIndicator {
    my ($name, $valid_args, $expected, $toofew_args, $toomany_args, $bad_expression) = @_;
    my ($got, $expect);

    my $expr = "datetime, $name($valid_args)";
    adhoc_test($expr, $expected, "$name value");
    throws_ok { $e->getIndicatorData( { symbol => $symbol, tf => $tf, numItems => 1, fields => "datetime, $name($toofew_args)", startPeriod => "2011-10-02 00:00:00", endPeriod => "2011-12-31 23:00:00" }) } qr/Syntax error in indicator/, "$name too few arguments" if (defined($toofew_args));
    throws_ok { $e->getIndicatorData( { symbol => $symbol, tf => $tf, numItems => 1, fields => "datetime, $name($toomany_args)", startPeriod => "2011-10-02 00:00:00", endPeriod => "2011-12-31 23:00:00"  }) } qr/Syntax error in indicator/, "$name too many arguments" if (defined($toomany_args));
    throws_ok { $e->getIndicatorData( { symbol => $symbol, tf => $tf, numItems => 1, fields => "datetime, $name($bad_expression)", startPeriod => "2011-10-02 00:00:00", endPeriod => "2011-12-31 23:00:00"  }) } qr/Syntax error in indicator/, "$name bad arguments expression" if (defined($bad_expression));
}

sub adhoc_test {
    my ($expr, $expected, $desc) = @_;
    
    my $got = $e->getIndicatorData( { symbol => $symbol, tf => $tf, numItems => 1, fields => $expr, startPeriod => "2011-10-02 00:00:00", endPeriod => "2012-05-31 23:00:00", maxLoadedItems => 125  });
    my $expect = ['2012-05-31 21:00:00', $expected];
    is_deeply($got->[0], $expect, $desc);
}
