#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Finance::HostedTrader::ExpressionParser;

my $parser = Finance::HostedTrader::ExpressionParser->new();

my $expression = "datetime,rsi(close,14)";
   $expression = "datetime,4hour(rsi(close,14)),8hour(atr(14)),8hour(sma(close,10))";
   $expression = "datetime,4hour(rsi(close,14)),30minute(rsi(close,14)),15minute(rsi(close,14)),5minute(rsi(close,14)),1minute(rsi(close,14))";
my $instrument  = 'EUR_GBP';
my $timeframe = '';

    my $args =
        {
            'expression'        => $expression,
            'instrument'        => $instrument,
            'item_count'        => 5,
            #'timeframe'         => '4hour',
            'test'              => 1,
        };
    my $result = $parser->getIndicatorData($args);
    print Dumper($result);
