#!/usr/bin/perl

eval 'exec /usr/bin/perl  -S $0 ${1+"$@"}'
    if 0; # not running under some shell
# ABSTRACT: Downloads historical data, inserts it into local database.
# PODNAME: fx-download.pl


use strict;
use warnings;
$|=1;

use Getopt::Long;
use Finance::HostedTrader::Config;
use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Provider;
use Finance::HostedTrader::Synthetics;
use Pod::Usage;
use Try::Tiny;

use Time::Piece;

my $numItemsToDownload = 10;
my ( $timeframes_from_txt, $instruments_from_txt, $verbose, $help, $service, $mode, $provider ) = ( undef, undef, 0, 0, 0, 'all', undef );

my $result = GetOptions(
    "instruments=s",    \$instruments_from_txt,
    "timeframes=s", \$timeframes_from_txt,
    "numItems=i",   \$numItemsToDownload,
    "verbose",      \$verbose,
    "service",      \$service,
    "mode=s",       \$mode,
    "provider=s",   \$provider,
    "help",         \$help)  or pod2usage(1);

pod2usage(1) if ( $help || !defined($timeframes_from_txt));

my $download_data = ($mode eq 'all' || $mode eq 'data_only');
my $calculate_synthetics = ($mode eq 'all' || $mode eq 'synthetics_only');

my $cfg = Finance::HostedTrader::Config->new();
my @instruments = split(',', $instruments_from_txt // '');
my @timeframes  = split(',', $timeframes_from_txt);

my $sleep_interval = $ENV{"DATA_DOWNLOAD_INTERVAL"} // 60;


# If the number of items being downloaded is small (and fast to download), keep a globally scoped database connection open
# Otherwise, the download can take minutes and it's preferable to only open the connection once we're ready to load the data
# as the database connection sometimes drops while the data is being downloaded from the provider
my $global_ds = ($numItemsToDownload < 500 ? Finance::HostedTrader::Datasource->new() : undef);

while (1) {

if (!$service || download_data()) {

    my $data_provider = $cfg->provider($provider);
    @instruments = $data_provider->getInstruments() unless(@instruments);

    if ($download_data) {
        foreach my $timeframe (@timeframes) {

            foreach my $instrument (@instruments) {
                print "Fetching $instrument $timeframe\n" if ($verbose);
                my $tableToLoad = $data_provider->getTableName($instrument, $timeframe);

                try {
                    my @buffer;
                    my $buffer_size = 0;
                    $data_provider->streamHistoricalData($instrument, $timeframe, $numItemsToDownload, sub {
                        my $candle = shift;

                        my $price_bid = $candle->{bid};
                        my $price_ask = $candle->{ask};
                        my $price_mid = $candle->{mid};
                        $candle->{time} =~ s/T/ /;
                        $candle->{time} =~ s/Z$//;

                        push @buffer,
                            $candle->{time},
                            $price_ask->{o},
                            $price_ask->{h},
                            $price_ask->{l},
                            $price_ask->{c},
                            $price_bid->{o},
                            $price_bid->{h},
                            $price_bid->{l},
                            $price_bid->{c},
                            $price_mid->{o},
                            $price_mid->{h},
                            $price_mid->{l},
                            $price_mid->{c},
                            $candle->{volume};

                        $buffer_size++;

                        if ($buffer_size >= 20) {
                            my $sql = "INSERT IGNORE INTO $tableToLoad (datetime, ask_open, ask_high, ask_low, ask_close, bid_open, bid_high, bid_low, bid_close, mid_open, mid_high, mid_low, mid_close, volume) VALUES " . ( "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)," x ($buffer_size) );
                            chop($sql);
                            
                            my $ds = (defined($global_ds) ? $global_ds :  Finance::HostedTrader::Datasource->new());
                            $ds->dbh->do($sql, undef, @buffer) or die($!);

                            @buffer = ();
                            $buffer_size=0;
                        }
                    });

                    if ($buffer_size) {
                        my $sql = "INSERT IGNORE INTO $tableToLoad (datetime, ask_open, ask_high, ask_low, ask_close, bid_open, bid_high, bid_low, bid_close, mid_open, mid_high, mid_low, mid_close, volume) VALUES " . ( "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)," x ($buffer_size) );
                        my $last_char = chop($sql);
                        $sql .= $last_char if ($last_char ne ',');

                        my $ds = (defined($global_ds) ? $global_ds :  Finance::HostedTrader::Datasource->new());
                        $ds->dbh->do($sql, undef, @buffer) or die($!);
                    }

                } catch {
                    warn "Failed to fetch $instrument $timeframe: $_";
                };
            }
        }
    }

    if ($calculate_synthetics) {
        my @instruments_synthetic = $data_provider->synthetic_names;
        my @tfs = sort { $a <=> $b } @{ $cfg->timeframes->all() };
        my $lowerTf = shift (@tfs);

        my $ds = (defined($global_ds) ? $global_ds :  Finance::HostedTrader::Datasource->new());
        foreach my $instrument (@instruments_synthetic) {
            print "Updating $instrument $lowerTf synthetic\n" if ($verbose);
            my $synthetic_info = $data_provider->synthetic->{$instrument} || die("Don't know how to calculate $instrument. Add it to fx.yml");
            my $table = $data_provider->getTableName($instrument, $lowerTf);
            my $select_sql = Finance::HostedTrader::Synthetics::get_synthetic_instrument(provider => $data_provider, instrument => $instrument, timeframe => $lowerTf, synthetic_info => $synthetic_info, incremental_base_table => "$table");

            my $sql = qq /REPLACE INTO ${table}
                ${select_sql};
            /;

            $ds->dbh->do($sql) or die("Error running '$sql'\n$!");
        }

        foreach my $instrument (@instruments, @instruments_synthetic) {
            foreach my $tf (@tfs) {
                print "Updating $instrument $tf synthetic\n" if ($verbose);
                my $table = $data_provider->getTableName($instrument, $tf);
                my $select_sql = Finance::HostedTrader::Synthetics::get_synthetic_timeframe(provider => $data_provider, instrument => $instrument, timeframe => $tf, incremental_base_table => "$table");

                my $sql = qq/REPLACE INTO $table
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

fx-download.pl - Downloads historical data from a provider and optionally insert it into the local database.

=head1 VERSION

version 0.022

=head1 SYNOPSIS

    fx-download.pl --timeframes=$TF1[,$TF2] [--instruments=SYM,...] [--verbose] [--help] [--numItems=i] [--mode=all|data_only|synthetics_only]

=head2 OPTIONS

=over

=item C<--timeframes=$TF1[,$TF2 ...]>

Required. A comma separated string of timeframe codes for which data is to be downloaded. See L<Finance::HostedTrader::Config::Timeframes> for available codes.

=item C<--instruments=$SYM1[,$SYM2 ...]>

Required. A comma separated string of instrument codes for which data is to be downloaded. See L<Finance::HostedTrader::Config::Symbols> for available codes.  Defaults to download every natural (as opposed to synthetic) instrument.

=item C<--numItems=i>

Optional. An integer representing how many items to download.  Defaults to 10.

=item C<--mode=s>

all - Downloads data only for the lower timeframe.  Synthetic instruments/timeframes are calculated via a query and inserted into their respective tables (default).

data_only - Downloads data only for the lower timeframe.  Synthetic instruments/timeframes are implemented as views ( calculated on the fly at run time ).

synthetic_only - Only calculate synthetic instruments/timeframes, without downloading any data from the provider.

=item C<--verbose>

Verbose output

=item C<--help>

Help screen

=back

=cut
