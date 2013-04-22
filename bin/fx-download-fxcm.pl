#!/usr/bin/perl
# ABSTRACT: Downloads historical data from fxcm, inserts it into local database and handles dependent synthetic symbols and timeframes
# PODNAME: fx-download-fxcm.pl

=head1 SYNOPSIS

    fx-download-fxcm.pl --timeframes=$TF1[,$TF2] [--verbose] [--help] [--start="15 days ago"] [--end="today] [--numItems=i]

=head2 OPTIONS

=over

=item C<--timeframes=$TF1[,$TF2 ...]>

Required. A comma separated string of timeframe codes for which data is to be downloaded. See L<Finance::HostedTrader::Config::Timeframes> for available codes.

=item C<--start=s>

Optional.  The date at which to start calculating data for synthetic symbols/timeframes. Defaults to 1900-01-01 which always works but can be slow. Only useful for performance reasons. Can be any value accepted by L<Date::Manip>.

=item C<--end=s>

Optional.  The date at which to end calculating data for synthetic symbols/timeframes. Defaults to 9998-12-31 which always works but can be slow. Only useful for performance reasons. Can be any value accepted by L<Date::Manip>.

=item C<--numItems=i>

Optional. An integer representing how many items to download.  Defaults to 10.

=item C<--verbose>

Verbose output

=item C<--help>

Help screen


=back

=cut

use strict;
use warnings;

use Getopt::Long;
use Date::Manip;
use Finance::HostedTrader::Config;
use Finance::HostedTrader::Account::FXCM::ForexConnect;
use Finance::FXCM::Simple;
use Pod::Usage;
use Try::Tiny;

my $numItemsToDownload = 10;
my ( $timeframes_from_txt, $start_date, $end_date, $verbose, $help ) = ( undef, '1900-01-01', '9998-12-31', 0, 0);

my $result = GetOptions(
    "start=s",      \$start_date,
    "end=s",        \$end_date,
    "timeframes=s", \$timeframes_from_txt,
    "numItems=i", \$numItemsToDownload,
    "verbose", \$verbose,
    "help", \$help)  or pod2usage(1);

pod2usage(1) if ( $help || !defined($timeframes_from_txt));

$start_date = UnixDate( $start_date, "%Y-%m-%d %H:%M:%S" )
  or die("Cannot parse $start_date");
$end_date = UnixDate( $end_date, "%Y-%m-%d %H:%M:%S" )
  or die("Cannot parse $end_date");

my $ds = Finance::HostedTrader::Datasource->new();
my $cfg = $ds->cfg;

my @naturalSymbols = @{ $cfg->symbols->natural };
my @timeframes  = sort split(',', $timeframes_from_txt);
my $providerCfg = $cfg->tradingProviders->{fxcm};

my $fxcm = Finance::FXCM::Simple->new($providerCfg->username, $providerCfg->password, $providerCfg->accountType, $providerCfg->serverURL);
my $syntheticSymbols = $cfg->symbols->synthetic;
my $syntheticTfs = $cfg->timeframes->synthetic();


while(@timeframes) {
    my $timeframe = shift(@timeframes);
    my $nextTimeframe = shift(@timeframes);
    my $fxcmTimeframe = Finance::HostedTrader::Account::FXCM::ForexConnect::convertTimeframeToFXCM($timeframe);

    foreach my $symbol (@naturalSymbols) {
        print "Fetching $symbol $timeframe\n" if ($verbose);
        my $tableToLoad = $symbol . '_' . $timeframe;

        try {
            $fxcm->saveHistoricalDataToFile($tableToLoad, Finance::HostedTrader::Account::FXCM::ForexConnect::convertSymbolToFXCM($symbol), $fxcmTimeframe, $numItemsToDownload);
            $ds->dbh->do("LOAD DATA LOCAL INFILE '$tableToLoad' IGNORE INTO TABLE $tableToLoad FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'") or die($!);
        } catch {
            warn "Failed to fetch $symbol $timeframe: $_";
        };
        unlink($tableToLoad);
    }

    foreach my $synthetic (@$syntheticSymbols) {
        print "Creating synthetic $synthetic $timeframe\n" if ($verbose);
        $ds->createSynthetic( $synthetic, $timeframe );
    }

    foreach my $dst_timeframe ( @{$syntheticTfs} ) {
        next if ( $dst_timeframe <= $timeframe );
        next if ( defined($nextTimeframe) && $dst_timeframe >= $nextTimeframe);
        foreach my $symbol ( @{$syntheticSymbols}, @naturalSymbols ) {
            print "Creating synthetic timeframe $dst_timeframe from $timeframe for $symbol\n" if ($verbose);
            $ds->convertOHLCTimeSeries( symbol => $symbol, tf_src => $timeframe, tf_dst => $dst_timeframe,
                start_date => $start_date, end_date => $end_date );
        }
        #$timeframe = $dst_timeframe if ( $dst_timeframe % $timeframe == 0 ); TODO: This would speed up calculations but i can't get it to work when dst_timeframe is 3 hours and previously calculated timeframe is 2 hours
    }

    unshift(@timeframes, $nextTimeframe) if ($nextTimeframe);
}
