#!/usr/bin/perl
# ABSTRACT: Outputs the value of a signal against all known symbols
# PODNAME: fx-test-signal.pl

=head1 SYNOPSIS

    fx-test-signal.pl [--timeframe=tf] [--verbose] [--symbols=s] [--debug] [--maxLoadedItems=i] [--numItems=i] expr


=head1 DESCRIPTION

Sample expressions:

close > ema(close,21)


=head2 OPTIONS

=over 12

=item C<--timeframe=tf>

Required argument. Specifies a single timeframe

tf can be a valid integer timeframe as defined in L<Finance::HostedTrader::Datasource>

=item C<--symbols=s>

Comma separated list of symbols for which to run the indicator against.
If not supplied, defaults to the list entry in the config file item "symbols.synthetic" and "symbols.natural".

=item C<--help>

Display usage information.

=item C<--debug>

Debug output. TODO, set log4perl to debug and output to STDERR.

=item C<--maxLoadedItems=i>

Number of database records to load. Defaults to 1000 which should be enough to calculate any indicator.

=item C<--numItems=i>

Number of signal periods to display. By default, all signals in studied period will be displayed.

=item C<--start=s>

The date to start calculating signals from. Defaults to 90 days ago. Any expression understood by L<Date::Manip> is valid.

=item C<--end=s>

The date to calculate signals to. Defaults to today. Any expression understood by L<Date::Manip> is valid.

=back

=head1 SEE ALSO

L<Finance::HostedTrader::Datasource>, L<Date::Manip>

=cut

use strict;
use warnings;

use Finance::HostedTrader::Config;
use Finance::HostedTrader::ExpressionParser;

use Data::Dumper;
use Date::Manip;
use Getopt::Long;
use Pod::Usage;

my ( $timeframe, $max_loaded_items, $symbols_txt, $debug, $help, $startPeriod, $endPeriod, $numItems, $verbose ) =
  ( 'day', undef, '', 0, 0, '90 days ago', 'today', undef, 0 );

GetOptions(
    "timeframe=s"         => \$timeframe,
    "numItems=i"         => \$numItems,
    "debug"               => \$debug,
    "verbose"               => \$verbose,
    "symbols=s"           => \$symbols_txt,
    "maxLoadedItems=i"  => \$max_loaded_items,
    "start=s" => \$startPeriod,
    "end=s" => \$endPeriod,
) || pod2usage(2);
pod2usage(1) if ($help);

my $cfg               = Finance::HostedTrader::Config->new();
my $signal_processor = Finance::HostedTrader::ExpressionParser->new();

my $symbols = $cfg->symbols->natural;

$symbols = [ split( ',', $symbols_txt ) ] if ($symbols_txt);


foreach my $signal (@ARGV) {
print "$signal\n----------------------\n" if ($verbose);
foreach my $symbol ( @{$symbols} ) {
    print "Testing $symbol\n" if ($verbose);
    my $data = $signal_processor->getSignalData(
        {
            'expr'            => $signal,
            'numItems'        => $numItems,
            'symbol'          => $symbol,
            'tf'              => $timeframe,
            'maxLoadedItems'  => $max_loaded_items,
            'startPeriod'     => UnixDate($startPeriod, '%Y-%m-%d %H:%M:%S'),
            'endPeriod'       => UnixDate($endPeriod, '%Y-%m-%d %H:%M:%S'),
        }
    );
    print $symbol, ' - ', Dumper(\$data) if (scalar(@$data));
}
}
