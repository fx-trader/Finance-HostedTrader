#!/usr/bin/perl

# PODNAME: fx-trend.pl
# ABSTRACT: List assets sorted by trend

=head1 SYNOPSIS

    fx-trend.pl [--timeframe=tf] [--symbols=s] [--debug] [--maxLoadedItems=i] [--numItems=i] expr


=head1 DESCRIPTION

Sample expressions:

rsi(close,14)

ema(close,21)


=head2 OPTIONS

=over 12

=item C<--average=i>

Optional. If specified, average the trend values by an EMA of i periods.

=item C<--timeframe=tf>

Optional argument. Specifies a single timeframe. Defaults to week.

tf can be a valid integer timeframe as defined in L<Finance::HostedTrader::Datasource>


=back

=head1 SEE ALSO

L<Finance::HostedTrader::Datasource>

=cut



use strict;
use warnings;

use Finance::HostedTrader::ExpressionParser;
use Finance::HostedTrader::Config;

use Data::Dumper;
use Getopt::Long;

my ( $timeframe, $max_loaded_items, $average ) = ( 'week', 1000, 0 );

my $result = GetOptions(
    "timeframe=s",          \$timeframe,
    "average=i",            \$average,
) || exit(1);

my $signal_processor = Finance::HostedTrader::ExpressionParser->new();
my %scores;
my $c = Finance::HostedTrader::Config->new();
my $symbols = $c->symbols->get_symbols_by_denominator("USD");

my $fields  =   "datetime," . ($average ? "ema(trend(close,21),13)" : "trend(close,21)" );

foreach my $symbol ( @$symbols ) {
    my $asset = $c->symbols->getSymbolNumerator($symbol);
    my $data = $signal_processor->getIndicatorData(
        {
            'fields'          => $fields,
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
            'fields'          => $fields,
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
