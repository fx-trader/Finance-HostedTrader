#!/usr/bin/perl

eval 'exec /usr/bin/perl  -S $0 ${1+"$@"}'
    if 0; # not running under some shell
# PODNAME: fx-score.pl
# ABSTRACT: List FX currencies sorted by relative strength

use strict;
use warnings;

use Finance::HostedTrader::ExpressionParser;

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

my %symbols = (
    AUD => { s => 'AUDUSD', m => 1 },
    EUR => { s => 'EURUSD', m => 1 },
    CAD => { s => 'USDCAD', m => -1 },
    GBP => { s => 'GBPUSD', m => 1 },
    NZD => { s => 'NZDUSD', m => 1 },
    CHF => { s => 'USDCHF', m => -1 },
    JPY => { s => 'USDJPY', m => -1 },
    OIL => { s => 'USOil',  m => 1 },
    XAG => { s => 'XAGUSD', m => 1 },
    XAU => { s => 'XAUUSD', m => 1 },
    GER30 => { s => 'GER30USD', m => 1 },
    Bund => { s => 'BundUSD', m => 1 },
    FRA40 => { s => 'FRA40USD', m => 1 },
    AUS200 => { s => 'AUS200USD', m => 1 },
    ESP35 => { s => 'ESP35USD', m => 1 },
    ITA40 => { s => 'ITA40USD', m => 1 },
    UK100 => { s => 'UK100USD', m => 1 },
    UKOil => { s => 'UKOilUSD', m => 1 },
    EUSTX50 => { s => 'EUSTX50USD', m => 1 },
    HKG33 => { s => 'HKG33USD', m => 1 },
    JPN225 => { s => 'JPN225USD', m => 1 },
    SUI30 => { s => 'SUI30USD', m => 1 },
);

foreach my $asset ( keys(%symbols) ) {
    my $symbol = $symbols{$asset}->{s};
    my $data = $signal_processor->getIndicatorData(
        {
            'fields'          => 'datetime,ema(trend(close,21),13)',
            'symbol'          => $symbol,
            'tf'              => $timeframe,
            'maxLoadedItems'  => $max_loaded_items,
            'numItems'        => 1
        }
    );
    $scores{$asset} = $data->[0]->[1] * $symbols{$asset}->{m};
}
$scores{USD}=1;

foreach my $asset (keys %scores) {
    print $asset, " ", $scores{$asset}, "\n";
}
