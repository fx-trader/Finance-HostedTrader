#!/usr/bin/perl
# ABSTRACT: Downloads historical data from fxcm, inserts it into local database and handles dependent synthetic symbols and timeframes
# PODNAME: fx-download-fxcm.pl

use strict;
use warnings;

use Getopt::Long;
use Date::Manip;
use Finance::HostedTrader::Config;
use Finance::HostedTrader::Account::FXCM::ForexConnect;
use Finance::FXCM::Simple;
use Pod::Usage;

my $numItemsToDownload = 10;
my ( $timeframes_from_txt, $start_date, $end_date, $help ) = ( undef, '1900-01-01', '9998-12-31', 0 );

my $result = GetOptions(
    "start=s",      \$start_date,
    "end=s",        \$end_date,
    "timeframes=s", \$timeframes_from_txt,
    "numItems=i", \$numItemsToDownload,
    "help", \$help)  or pod2usage(1);

pod2usage(2) if ($help);
pod2usage(1) if (!defined($timeframes_from_txt));

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
        my $tableToLoad = $symbol . '_' . $timeframe;

        $fxcm->saveHistoricalDataToFile($tableToLoad, Finance::HostedTrader::Account::FXCM::ForexConnect::convertSymbolToFXCM($symbol), $fxcmTimeframe, $numItemsToDownload);
        $ds->dbh->do("LOAD DATA LOCAL INFILE '$tableToLoad' IGNORE INTO TABLE $tableToLoad FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'") or die($!);
        unlink($tableToLoad);
    }

    foreach my $synthetic (@$syntheticSymbols) {
        $ds->createSynthetic( $synthetic, $timeframe );
    }

    foreach my $dst_timeframe ( @{$syntheticTfs} ) {
        next if ( $dst_timeframe <= $timeframe );
        next if ( defined($nextTimeframe) && $dst_timeframe >= $nextTimeframe);
        foreach my $symbol ( @{$syntheticSymbols}, @naturalSymbols ) {
            $ds->convertOHLCTimeSeries( symbol => $symbol, tf_src => $timeframe, tf_dst => $dst_timeframe,
                start_date => $start_date, end_date => $end_date );
        }
        #$timeframe = $dst_timeframe if ( $dst_timeframe % $timeframe == 0 ); TODO: This would speed up calculations but i can't get it to work when dst_timeframe is 3 hours and previously calculated timeframe is 2 hours
    }

    unshift(@timeframes, $nextTimeframe) if ($nextTimeframe);
}
