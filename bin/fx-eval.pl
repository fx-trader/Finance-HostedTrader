#!/usr/bin/perl
# ABSTRACT: Outputs the value of an indicator against all known instruments
# PODNAME: fx-eval.pl

=head1 SYNOPSIS

    fx-eval.pl [--timeframe=tf] [--instruments=s] [--debug] [--max_loaded_items=i] [--item_count=i] [--sql_filter=s] expr


=head1 DESCRIPTION

Sample expressions:

rsi(close,14)

ema(close,21)


=head2 OPTIONS

=over 12

=item C<--timeframe=tf>

Optional. Specifies a single timeframe. Defaults to day.

tf can be a valid integer timeframe as defined in L<Finance::HostedTrader::Datasource>

=item C<--instruments=s>

Comma separated list of instruments for which to run the indicator against.

=item C<--help>

Display usage information.

=item C<--debug>

Debug output. TODO, set log4perl to debug and output to stderr.

=item C<--max_loaded_items=i>

Number of database records to load. Defaults to 1000 which should be enough to calculate any indicator.

=item C<--item_count=i>

Number of indicator periods to display. Defaults to one (eg: only display the indicator value today)

=item C<--sql_filter=s>

A generic filter to be added to the inner query. Examples include:

--sql_filter="DAYOFWEEK(datetime) == 2"

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

my ( $timeframe, $max_loaded_items, $max_display_items, $instruments_txt, $sql_filter, $debug, $help ) =
  ( 'day', 5000, 1, '', '', 0, 0 );

GetOptions(
    "timeframe=s"         => \$timeframe,
    "debug"               => \$debug,
    "instruments=s"       => \$instruments_txt,
    "sql_filter=s"        => \$sql_filter,
    "max_loaded_items=i"  => \$max_loaded_items,
    "item_count=i" => \$max_display_items,
) || pod2usage(2);
pod2usage(1) if ($help);

my $cfg               = Finance::HostedTrader::Config->new();
my $signal_processor = Finance::HostedTrader::ExpressionParser->new();

my $instruments = $cfg->symbols->all;

$instruments = [ split( ',', $instruments_txt ) ] if ($instruments_txt);
print "Processing in the $timeframe timeframe\n";
foreach my $symbol ( @{$instruments} ) {
    my $indicator_result = $signal_processor->getIndicatorData(
        {
            'expression'      => $ARGV[0],
            'symbol'          => $symbol,
            'timeframe'       => $timeframe,
            'max_loaded_items'=> $max_loaded_items,
            'item_count'      => $max_display_items,
            'sql_filter'      => $sql_filter,
        }
    );
    my $data = $indicator_result->{data};
    foreach my $item (@$data) {
        print "$symbol\t" . join( "\t", @$item ) . "\n";
    }
    print "$symbol\t" . Dumper( \$data ) if ($debug);
}
