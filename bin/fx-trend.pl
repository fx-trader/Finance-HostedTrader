#!/usr/bin/perl

# PODNAME: fx-trend.pl
# ABSTRACT: List assets sorted by trend

use strict;
use warnings;

use Finance::HostedTrader::ExpressionParser;
use Finance::HostedTrader::Config;

use Data::Dumper;
use Getopt::Long;

my ( $timeframe, $max_loaded_items, $verbose ) = ( 'week', 1000, 0 );
my @item_exclude;

my $result = GetOptions(
"timeframe=s", \$timeframe, 
"max-loaded-items=i",    \$max_loaded_items, 
"verbose", \$verbose, 
"exclude=s", \@item_exclude,
) || exit(1);

my $signal_processor = Finance::HostedTrader::ExpressionParser->new();
my %scores;
my $c = Finance::HostedTrader::Config->new();
my $symbols = $c->symbols->get_symbols_by_denominator("USD");

foreach my $symbol ( @$symbols ) {
    my $asset = $c->symbols->getSymbolNumerator($symbol);
    my $data = $signal_processor->getIndicatorData(
        {
            'fields'          => 'datetime,trend(close,21)',
            'symbol'          => $symbol,
            'tf'              => $timeframe,
            'maxLoadedItems'  => $max_loaded_items,
            'numItems'        => 1,
        }
    );
    $scores{$asset}{score}      = $data->[0][1];
    $scores{$asset}{datetime}   = $data->[0][0];  # Make datetime visible so that's it's clear if data is out of date
}

$symbols = $c->symbols->get_symbols_by_numerator("USD");
foreach my $symbol ( @$symbols ) {
    my $asset = $c->symbols->getSymbolDenominator($symbol);
    my $data = $signal_processor->getIndicatorData(
        {
            'fields'          => 'datetime,trend(close,21)',
            'symbol'          => $symbol,
            'tf'              => $timeframe,
            'maxLoadedItems'  => $max_loaded_items,
            'numItems'        => 1,
        }
    );
    $scores{$asset}{score}      = $data->[0][1] * (-1);
    $scores{$asset}{datetime}   = $data->[0][0];  # Make datetime visible so that's it's clear if data is out of date
}


foreach my $asset (keys %scores) {
    print $asset, " ", $scores{$asset}{score}, " ", $scores{$asset}{datetime}, "\n";
}
