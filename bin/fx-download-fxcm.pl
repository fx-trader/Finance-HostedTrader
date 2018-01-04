#!/usr/bin/perl

eval 'exec /usr/bin/perl  -S $0 ${1+"$@"}'
    if 0; # not running under some shell
# ABSTRACT: Downloads historical data from fxcm, inserts it into local database.
# PODNAME: fx-download-fxcm.pl


use strict;
use warnings;
$|=1;

use Getopt::Long;
use Finance::HostedTrader::Config;
use Finance::HostedTrader::Datasource;
use Finance::FXCM::Simple;
use Pod::Usage;
use Try::Tiny;

my %symbolMap = (
    AUDCAD => 'AUD/CAD',
    AUDCHF => 'AUD/CHF',
    AUDJPY => 'AUD/JPY',
    AUDNZD => 'AUD/NZD',
    AUDUSD => 'AUD/USD',
    AUS200 => 'AUS200',
    CADCHF => 'CAD/CHF',
    CADJPY => 'CAD/JPY',
    CHFJPY => 'CHF/JPY',
    CHFNOK => 'CHF/NOK',
    CHFSEK => 'CHF/SEK',
    EURAUD => 'EUR/AUD',
    EURCAD => 'EUR/CAD',
    EURCHF => 'EUR/CHF',
    EURDKK => 'EUR/DKK',
    EURGBP => 'EUR/GBP',
    EURJPY => 'EUR/JPY',
    EURNOK => 'EUR/NOK',
    EURNZD => 'EUR/NZD',
    EURSEK => 'EUR/SEK',
    EURTRY => 'EUR/TRY',
    EURUSD => 'EUR/USD',
    GBPAUD => 'GBP/AUD',
    GBPCAD => 'GBP/CAD',
    GBPCHF => 'GBP/CHF',
    GBPJPY => 'GBP/JPY',
    GBPNZD => 'GBP/NZD',
    GBPSEK => 'GBP/SEK',
    GBPUSD => 'GBP/USD',
    HKDJPY => 'HKD/JPY',
    NOKJPY => 'NOK/JPY',
    NZDCAD => 'NZD/CAD',
    NZDCHF => 'NZD/CHF',
    NZDJPY => 'NZD/JPY',
    NZDUSD => 'NZD/USD',
    SEKJPY => 'SEK/JPY',
    SGDJPY => 'SGD/JPY',
    TRYJPY => 'TRY/JPY',
    USDCAD => 'USD/CAD',
    USDCHF => 'USD/CHF',
    USDDKK => 'USD/DKK',
    USDHKD => 'USD/HKD',
    USDJPY => 'USD/JPY',
    USDMXN => 'USD/MXN',
    USDNOK => 'USD/NOK',
    USDSEK => 'USD/SEK',
    USDSGD => 'USD/SGD',
    USDTRY => 'USD/TRY',
    USDZAR => 'USD/ZAR',
    XAGUSD => 'XAG/USD',
    XAUUSD => 'XAU/USD',
    ZARJPY => 'ZAR/JPY',
    ESP35  => 'ESP35',
    FRA40  => 'FRA40',
    GER30  => 'GER30',
    HKG33  => 'HKG33',
    ITA40  => 'ITA40',
    JPN225 => 'JPN225',
    NAS100 => 'NAS100',
    SPX500 => 'SPX500',
    SUI30  => 'SUI30',
    SWE30  => 'SWE30',
    UK100  => 'UK100',
    UKOil  => 'UKOil',
    US30   => 'US30',
    USOil  => 'USOil',
    Copper => 'Copper',
    XPTUSD => 'XPT/USD',
    XPDUSD => 'CPD/USD',
    USDOLLAR=> 'USDOLLAR',
    NGAS    => 'NGAS',
    EUSTX50 => 'EUSTX50',
    Bund    => 'Bund',
);

my %timeframeMap = (
    60     => 'm1',
    300    => 'm5',
    3600   => 'H1',
    86400  => 'D1',
    604800 => 'W1',
);


sub convertSymbolToFXCM {
    my ($symbol) = @_;

    die("Unsupported symbol '$symbol'") if (!exists($symbolMap{$symbol}));
    return $symbolMap{$symbol};
}

sub convertTimeframeToFXCM {
    my ($timeframe) = @_;

    die("Unsupported timeframe '$timeframe'") if (!exists($timeframeMap{$timeframe}));
    return $timeframeMap{$timeframe};
}



my $numItemsToDownload = 10;
my ( $timeframes_from_txt, $symbols_from_txt, $verbose, $help, $service ) = ( undef, undef, 0, 0, 0);

my $result = GetOptions(
    "symbols=s",    \$symbols_from_txt,
    "timeframes=s", \$timeframes_from_txt,
    "numItems=i",   \$numItemsToDownload,
    "verbose",      \$verbose,
    "service",      \$service,
    "help",         \$help)  or pod2usage(1);

pod2usage(1) if ( $help || !defined($timeframes_from_txt));

my $cfg = Finance::HostedTrader::Config->new();
my @symbols = ( $symbols_from_txt ? split(',', $symbols_from_txt) : @{ $cfg->symbols->natural } );
my @timeframes  = sort split(',', $timeframes_from_txt);
my $providerCfg = $cfg->tradingProviders->{fxcm};

my $sleep_interval = $ENV{"FXCM_DOWNLOAD_INTERVAL"} // 300;


# If the number of items being downloaded is small (and fast to download), keep a globally scoped database connection open
# Otherwise, the download can take minutes and it's preferable to only open the connection once we're ready to load the data
# as the database connection sometimes drops while the data is being downloaded from the provider
my $global_ds = ($numItemsToDownload < 500 ? Finance::HostedTrader::Datasource->new() : undef);

while (1) {

if (!$service || download_data()) {

    my $fxcm = Finance::FXCM::Simple->new($providerCfg->username, $providerCfg->password, $providerCfg->accountType, $providerCfg->serverURL);
    foreach my $timeframe (@timeframes) {
        my $fxcmTimeframe = convertTimeframeToFXCM($timeframe);

        foreach my $symbol (@symbols) {
            print "Fetching $symbol $timeframe\n" if ($verbose);
            my $tableToLoad = $symbol . '_' . $timeframe;

            try {
                $fxcm->saveHistoricalDataToFile($tableToLoad, convertSymbolToFXCM($symbol), $fxcmTimeframe, $numItemsToDownload);
                my $ds = (defined($global_ds) ? $global_ds :  Finance::HostedTrader::Datasource->new());
                $ds->dbh->do("LOAD DATA LOCAL INFILE '$tableToLoad' IGNORE INTO TABLE $tableToLoad FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'") or die($!);
                unlink($tableToLoad);
            } catch {
                warn "Failed to fetch $symbol $timeframe: $_";
            };
        }
    }

    $fxcm = undef;

} else {

    print "Skip download data\n" if ($verbose);

}

last unless ($service);

print "Waiting $sleep_interval seconds\n" if ($verbose);
sleep($sleep_interval);


}

# Returns false when outside market hours
sub download_data {
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime(time);

return 0 if ($wday == 6); # Saturday
return 0 if ($wday == 5 && $hour >= 22); # Friday after 22H00
return 0 if ($wday == 0 && $hour <= 20); # Sunday before 21H00
return 1;
}

__END__

=pod

=encoding UTF-8

=head1 NAME

fx-download-fxcm.pl - Downloads historical data from fxcm, inserts it into local database.

=head1 VERSION

version 0.022

=head1 SYNOPSIS

    fx-download-fxcm.pl --timeframes=$TF1[,$TF2] [--symbols=SYM,...] [--verbose] [--help] [--start="15 days ago"] [--end="today] [--numItems=i]

=head2 OPTIONS

=over

=item C<--timeframes=$TF1[,$TF2 ...]>

Required. A comma separated string of timeframe codes for which data is to be downloaded. See L<Finance::HostedTrader::Config::Timeframes> for available codes.

=item C<--symbols=$SYM1[,$SYM2 ...]>

Required. A comma separated string of symbol codes for which data is to be downloaded. See L<Finance::HostedTrader::Config::Symbols> for available codes.  Defaults to download every natural (as opposed to synthetic) symbol.

=item C<--numItems=i>

Optional. An integer representing how many items to download.  Defaults to 10.

=item C<--verbose>

Verbose output

=item C<--help>

Help screen

=back

=head1 METHODS

=head2 C<convertSymbolToFXCM>

=head2 C<convertTimeframeToFXCM>

=head1 AUTHOR

João Costa <joaocosta@zonalivre.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by João Costa.

This is free software, licensed under:

  The MIT (X11) License

=cut
