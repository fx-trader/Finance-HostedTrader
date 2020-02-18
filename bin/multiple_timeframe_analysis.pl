#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

use Finance::HostedTrader::ExpressionParser;

my $parser = Finance::HostedTrader::ExpressionParser->new();

my $instrument = "XAU_EUR";
my $max_loaded_items = "25000";
my $timeframe = '5minute';
my $provider = 'oanda_historical';

=pod
my $expression = "rsi(close,14) < 30 AND 2hour(sma(close,20)) + 5*2hour(atr(14)) < close";
   $expression = "rsi(close,14) < 30 AND 15minute(rsi(close,14)) < 30 AND 30minute(rsi(close,14)) < 30";
   $expression = "rsi(close,14) < 30 AND 15minute(rsi(close,14)) < 30 AND 30minute(rsi(close,14)) < 30";
   $expression = "8hour(sma(close,200)) < close";
   $expression = "(8hour(sma(close,200)) + 2*8hour(atr(14))) < close AND 4hour(rsi(close,14)) < 30";

my $args =
    {
        'expression'        => $expression,
        'instrument'        => $instrument,
        'timeframe'         => $timeframe,
        'max_loaded_items'  => $max_loaded_items,
        'provider'          => $provider,
        'item_count'        => 10,
    };

my $result = $parser->getSignalData( $args );

print "FINAL_RESULT = " . Dumper($result);
=cut

my $expression = "datetime,rsi(close,14)";
   $expression = "datetime,4hour(rsi(close,14)),8hour(atr(14)),8hour(sma(close,10))";
   $expression = "datetime,4hour(rsi(close,14)),30minute(rsi(close,14)),15minute(rsi(close,14)),5minute(rsi(close,14)),1minute(rsi(close,14))";
   $expression = "datetime,8hour(sma(close,200)),8hour(atr(14))";
   $expression = "datetime,sma(close,200),atr(14),30minute(atr(14))";

    my $args =
        {
            'expression'        => $expression,
            'instrument'        => $instrument,
            'item_count'        => 5,
            'timeframe'         => $timeframe,
            'provider'          => $provider,
            'max_loaded_items'  => $max_loaded_items,
        };
    my $result = $parser->getIndicatorData($args);
    print Dumper($result);
