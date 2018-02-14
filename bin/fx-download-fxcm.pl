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
use Finance::HostedTrader::DataProvider;
use Finance::HostedTrader::Synthetics;
use Pod::Usage;
use Try::Tiny;


my $numItemsToDownload = 10;
my ( $timeframes_from_txt, $symbols_from_txt, $verbose, $help, $service, $mode ) = ( undef, undef, 0, 0, 0, 'simple' );

my $result = GetOptions(
    "symbols=s",    \$symbols_from_txt,
    "timeframes=s", \$timeframes_from_txt,
    "numItems=i",   \$numItemsToDownload,
    "verbose",      \$verbose,
    "service",      \$service,
    "mode=s",       \$mode,
    "help",         \$help)  or pod2usage(1);

pod2usage(1) if ( $help || !defined($timeframes_from_txt));

my $cfg = Finance::HostedTrader::Config->new();
my @symbols = ( $symbols_from_txt ? split(',', $symbols_from_txt) : @{ $cfg->symbols->natural } );
my @timeframes  = sort split(',', $timeframes_from_txt);

my $sleep_interval = $ENV{"DATA_DOWNLOAD_INTERVAL"} // 300;


# If the number of items being downloaded is small (and fast to download), keep a globally scoped database connection open
# Otherwise, the download can take minutes and it's preferable to only open the connection once we're ready to load the data
# as the database connection sometimes drops while the data is being downloaded from the provider
my $global_ds = ($numItemsToDownload < 500 ? Finance::HostedTrader::Datasource->new() : undef);

while (1) {

if (!$service || download_data()) {

    my $data_provider = Finance::HostedTrader::DataProvider->factory('FXCM');
    foreach my $timeframe (@timeframes) {

        foreach my $symbol (@symbols) {
            print "Fetching $symbol $timeframe\n" if ($verbose);
            my $tableToLoad = $symbol . '_' . $timeframe;

            try {
                $data_provider->saveHistoricalDataToFile($tableToLoad, $symbol, $timeframe, $numItemsToDownload);
                my $ds = (defined($global_ds) ? $global_ds :  Finance::HostedTrader::Datasource->new());
                $ds->dbh->do("LOAD DATA LOCAL INFILE '$tableToLoad' IGNORE INTO TABLE $tableToLoad FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'") or die($!);
                unlink($tableToLoad);
            } catch {
                warn "Failed to fetch $symbol $timeframe: $_";
            };
        }
    }

    $data_provider = undef;

    if ($mode eq 'simple') {
        my $symbols = $cfg->symbols->natural();
        my $symbols_synthetic = $cfg->symbols->synthetic();
        my @tfs = sort { $a <=> $b } @{ $cfg->timeframes->all() };
        my $lowerTf = shift (@tfs);

        my $ds = (defined($global_ds) ? $global_ds :  Finance::HostedTrader::Datasource->new());
        foreach my $symbol (keys %$symbols_synthetic) {
            print "Updating $symbol $lowerTf synthetic\n" if ($verbose);
            my $synthetic_info = $cfg->symbols->synthetic->{$symbol} || die("Don't know how to calculate $symbol. Add it to fx.yml");
            my $select_sql = Finance::HostedTrader::Synthetics::get_synthetic_symbol(symbol => $symbol, timeframe => $lowerTf, synthetic_info => $synthetic_info, incremental_base_table => "${symbol}_${lowerTf}");

            my $sql = qq /REPLACE INTO ${symbol}_${lowerTf}
                ${select_sql};
            /;

            $ds->dbh->do($sql) or die($!);
        }

        foreach my $symbol (@$symbols, keys %$symbols_synthetic) {
            foreach my $tf (@tfs) {
                print "Updating $symbol $tf synthetic\n" if ($verbose);
                my $select_sql = Finance::HostedTrader::Synthetics::get_synthetic_timeframe(symbol => $symbol, timeframe => $tf, incremental_base_table => "${symbol}_${tf}");

                my $sql = qq/REPLACE INTO ${symbol}_${tf}
                $select_sql/;

                $ds->dbh->do($sql) or die($!);
            }
        }
    }

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

    fx-download-fxcm.pl --timeframes=$TF1[,$TF2] [--symbols=SYM,...] [--verbose] [--help] [--start="15 days ago"] [--end="today] [--numItems=i] [--mode=simple|views]

=head2 OPTIONS

=over

=item C<--timeframes=$TF1[,$TF2 ...]>

Required. A comma separated string of timeframe codes for which data is to be downloaded. See L<Finance::HostedTrader::Config::Timeframes> for available codes.

=item C<--symbols=$SYM1[,$SYM2 ...]>

Required. A comma separated string of symbol codes for which data is to be downloaded. See L<Finance::HostedTrader::Config::Symbols> for available codes.  Defaults to download every natural (as opposed to synthetic) symbol.

=item C<--numItems=i>

Optional. An integer representing how many items to download.  Defaults to 10.

=item C<--mode=s>

simple - Downloads data only for the lower timeframe.  Synthetic symbols/timeframes are calculated via a query and inserted into their respective tables (default).
views - Downloads data only for the lower timeframe.  Synthetic symbols/timeframes are implemented as views ( calculated on the fly at run time ).


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
