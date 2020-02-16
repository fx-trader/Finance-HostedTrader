#!/usr/bin/perl
# ABSTRACT: Outputs the value of an indicator against all known instruments
# PODNAME: fx-eval.pl

=head1 SYNOPSIS

    fx-eval.pl [--timeframe=tf] [--instruments=s] [--debug] [--max_loaded_items=i] [--item_count=i] [--inner_sql_filter=s] [--provider=s] expr


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

=item C<--inner_sql_filter=s>

A generic filter to be added to the inner query. Examples include:

--inner_sql_filter="DAYOFWEEK(datetime) = 2"

=item C<--provider=s>

The data provider to use.  See providers defined in /etc/fxtrader/fx.yml .

=back

=head1 SEE ALSO

L<Finance::HostedTrader::Datasource>

=cut

use strict;
use warnings;

use Finance::HostedTrader::Config;
use Finance::HostedTrader::Provider;
use Finance::HostedTrader::ExpressionParser;

use Data::Dumper;
use Getopt::Long;
use Pod::Usage;

my ( $timeframe, $max_loaded_items, $max_display_items, $instruments_txt, $inner_sql_filter, $provider, $debug, $help ) =
  ( 'day', 5000, 1, '', '', undef, 0, 0 );

GetOptions(
    "timeframe=s"         => \$timeframe,
    "debug"               => \$debug,
    "instruments=s"       => \$instruments_txt,
    "inner_sql_filter=s"  => \$inner_sql_filter,
    "max_loaded_items=i"  => \$max_loaded_items,
    "item_count=i" => \$max_display_items,
    "provider=s" => \$provider,
) || pod2usage(2);
pod2usage(1) if ($help or !$ARGV[0]);

my $cfg               = Finance::HostedTrader::Config->new();
my $signal_processor = Finance::HostedTrader::ExpressionParser->new();

my $data_provider = $cfg->provider();
my @instruments = $data_provider->getAllInstruments();

@instruments = split( ',', $instruments_txt ) if ($instruments_txt);
print "Processing in the $timeframe timeframe\n";
foreach my $instrument ( @instruments ) {
    my $indicator_result = $signal_processor->getIndicatorData(
        {
            'expression'      => $ARGV[0],
            'instrument'      => $instrument,
            'timeframe'       => $timeframe,
            'max_loaded_items'=> $max_loaded_items,
            'item_count'      => $max_display_items,
            'inner_sql_filter'=> $inner_sql_filter,
            'provider'        => $provider,
        }
    );
    my $data = $indicator_result->{data};
    foreach my $item (@$data) {
        print "$instrument\t" . join( "\t", @$item ) . "\n";
    }
    print "$instrument\t" . Dumper( \$data ) if ($debug);
}
