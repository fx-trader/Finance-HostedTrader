#!/usr/bin/perl
# ABSTRACT: Outputs the value of a signal against all known instruments
# PODNAME: fx-test-signal.pl

=head1 SYNOPSIS

    fx-test-signal.pl [--timeframe=tf] [--verbose] [--instruments=s] [--start=s] [--end=s] [--debug] [--max_loaded_items=i] [--item_count=i] expr


=head1 DESCRIPTION

Sample expressions:

close > ema(close,21)


=head2 OPTIONS

=over 12

=item C<--timeframe=tf>

Required argument. Specifies a single timeframe

tf can be a valid integer timeframe as defined in L<Finance::HostedTrader::Datasource>

=item C<--instruments=s>

Comma separated list of instruments for which to run the indicator against.

=item C<--help>

Display usage information.

=item C<--debug>

Debug output. TODO, set log4perl to debug and output to STDERR.

=item C<--max_loaded_items=i>

Number of database records to load. Defaults to 1000 which should be enough to calculate any indicator.

=item C<--item_count=i>

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

my ( $timeframe, $max_loaded_items, $instruments_txt, $debug, $help, $startPeriod, $endPeriod, $item_count, $provider, $verbose ) =
  ( 'day', undef, '', 0, 0, '90 days ago', undef, undef, undef, 0 );

GetOptions(
    "timeframe=s"         => \$timeframe,
    "item_count=i"         => \$item_count,
    "debug"               => \$debug,
    "verbose"               => \$verbose,
    "instruments=s"           => \$instruments_txt,
    "max_loaded_items=i"  => \$max_loaded_items,
    "start=s" => \$startPeriod,
    "end=s" => \$endPeriod,
    "provider=s" => \$provider,
) || pod2usage(2);
pod2usage(1) if ($help);

my $cfg               = Finance::HostedTrader::Config->new();
my $signal_processor = Finance::HostedTrader::ExpressionParser->new();

my $data_provider = $cfg->provider($provider);
my @instruments = $data_provider->getInstruments();

@instruments = split( ',', $instruments_txt ) if ($instruments_txt);


foreach my $signal (@ARGV) {
print "$signal\n----------------------\n" if ($verbose);
foreach my $instrument ( @instruments ) {
    print "Testing $instrument\n" if ($verbose);
    my $signal_args = 
        {
            'expression'        => $signal,
            'item_count'        => $item_count,
            'instrument'        => $instrument,
            'timeframe'         => $timeframe,
            'max_loaded_items'  => $max_loaded_items,
            'start_period'      => UnixDate($startPeriod, '%Y-%m-%d %H:%M:%S'),
            'provider'          => $provider,
        };
    $signal_args->{endPeriod} = UnixDate($endPeriod, '%Y-%m-%d %H:%M:%S') if (defined($endPeriod));
    my $signal_result = $signal_processor->getSignalData( $signal_args );
    my $data = $signal_result->{data};
    print $instrument, ' - ', Dumper(\$data) if (scalar(@$data));
}
}
