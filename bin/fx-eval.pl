#!/usr/bin/perl
# ABSTRACT: Outputs the value of an indicator against all known symbols
# PODNAME: fx-eval.pl

=head1 SYNOPSIS

    fx-eval.pl [--timeframe=tf] [--symbols=s] [--debug] [--maxLoadedItems=i] [--numItems=i] expr


=head1 DESCRIPTION

Sample expressions:

rsi(close,14)

ema(close,21)


=head2 OPTIONS

=over 12

=item C<--timeframe=tf>

Optional. Specifies a single timeframe. Defaults to day.

tf can be a valid integer timeframe as defined in L<Finance::HostedTrader::Datasource>

=item C<--symbols=s>

Comma separated list of symbols for which to run the indicator against.
If not supplied, defaults to the list entry in the config file item "symbols.synthetic" and "symbols.natural".

=item C<--help>

Display usage information.

=item C<--debug>

Debug output. TODO, set log4perl to debug and output to stderr.

=item C<--maxLoadedItems=i>

Number of database records to load. Defaults to 1000 which should be enough to calculate any indicator.

=item C<--numItems=i>

Number of indicator periods to display. Defaults to one (eg: only display the indicator value today)

=back

=head1 SEE ALSO

L<Finance::HostedTrader::Datasource>

=cut

use strict;
use warnings;

use Finance::HostedTrader::Config;
use Finance::HostedTrader::ExpressionParser;

use Data::Dumper;
use Getopt::Long;
use Pod::Usage;

my ( $timeframe, $max_loaded_items, $max_display_items, $symbols_txt, $debug, $help ) =
  ( 'day', 5000, 1, '', 0, 0 );

GetOptions(
    "timeframe=s"         => \$timeframe,
    "debug"               => \$debug,
    "symbols=s"           => \$symbols_txt,
    "maxLoadedItems=i"  => \$max_loaded_items,
    "numItems=i" => \$max_display_items,
) || pod2usage(2);
pod2usage(1) if ($help);

my $cfg               = Finance::HostedTrader::Config->new();
my $signal_processor = Finance::HostedTrader::ExpressionParser->new();

my $symbols = $cfg->symbols->all;

$symbols = [ split( ',', $symbols_txt ) ] if ($symbols_txt);
print "Processing in the $timeframe timeframe\n";
foreach my $symbol ( @{$symbols} ) {
    my $indicator_result = $signal_processor->getIndicatorData(
        {
            'fields'           => $ARGV[0],
            'symbol'          => $symbol,
            'tf'              => $timeframe,
            'maxLoadedItems'  => $max_loaded_items,
            'numItems' => $max_display_items,
        }
    );
    my $data = $indicator_result->{data};
    foreach my $item (@$data) {
        print "$symbol\t" . join( "\t", @$item ) . "\n";
    }
    print "$symbol\t" . Dumper( \$data ) if ($debug);
}
