#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Finance::HostedTrader::ExpressionParser;

my $parser = Finance::HostedTrader::ExpressionParser->new();


my $expression = "rsi(close,14) < 30 AND 2hour(sma(close,20)) + 5*2hour(atr(14)) < close";
   $expression = "rsi(close,14) < 30 AND 15minute(rsi(close,14)) < 30 AND 30minute(rsi(close,14)) < 30";
   $expression = "rsi(close,14) < 30 AND 15minute(rsi(close,14)) < 30 AND 30minute(rsi(close,14)) < 30";
   $expression = "8hour(sma(close,200) + 5*atr(14)) < close";
   $expression = "8hour(sma(close,200)) < close";
#   $expression = "rsi(close,14) < 30 AND (high > close OR low < close)";
my $instrument = "XAU_EUR";
my $max_loaded_items = "25000";
my $timeframe = '5min';

my $args =
    {
        'expression'        => $expression,
        'instrument'        => $instrument,
        'timeframe'         => $timeframe,
        'max_loaded_items'  => $max_loaded_items,
        'provider'          => 'oanda_historical',
    };

my $result = $parser->getSignalData( $args );

print "FINAL_RESULT = " . Dumper($result);

=pod
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
=cut
