#!/usr/bin/perl
# ABSTRACT: Generates statments which can be used against all symbols/timeframes
# PODNAME: fx-all-tables.pl

=head1 SYNOPSIS

    fx-all-tables.pl --template "TABLE_NAME INSTRUMENT_NAME TIMEFRAME_NAME" --timeframes=$TF1[,$TF2] --instruments=EURUSD,[GBPUSD]] --providers=oanda,[oanda_historical,fxcm]

=head2 OPTIONS

=over

=item C<--timeframes=$TF1[,$TF2 ...]>

Optional. A comma separated string of timeframe codes for which data is to be downloaded.
See L<Finance::HostedTrader::Config::Timeframes> for available codes.
Defaults to all timeframes defined in /etc/fxtrader/fx.yml .

=item C<--instruments=s>

Optional. A comma separated string of instruments to process.
Defaults to all instruments supported by the provider.

=item C<--template=s>

Required.  The template for what statment will be output.

=over 4

=item * The string "TABLE_NAME" will be replaced by the name of the db table that supports a given provider/instrument/timeframe, ie: oanda_EUR_USD_60.

=item * The string "INSTRUMENT_NAME" will be replaced by the name of the instrument, ie: EUR_USD.

=item * The string "TIMEFRAME_NAME" will be replaced by the name of the timeframe, ie: 60.

=back

Defaults to "TABLE_NAME".

=item C<--help>

Help screen


=back

=cut



use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use Finance::HostedTrader::Datasource;

my ($template, $join, $prefix, $suffix, $timeframes_txt, $instruments_txt, $providers_txt, $help) = ("", "\n", "", "");

my $result = GetOptions(
                        "timeframes=s", \$timeframes_txt,
                        "instruments=s",\$instruments_txt,
                        "providers=s",  \$providers_txt,
                        "template=s",   \$template,
                        "join=s",       \$join,
                        "prefix=s",     \$prefix,
                        "suffix=s",     \$suffix,
                        "help", \$help,
                    )  or pod2usage(1);

pod2usage(1) if ( $help );
pod2usage(1) if (!$template);

my $db = Finance::HostedTrader::Datasource->new();


my $timeframes = $db->cfg->timeframes->all;
$timeframes = [split(',',$timeframes_txt)] if ($timeframes_txt);

my @providers_filter = split(/,/, $providers_txt // '');

$db->cfg->forEachProvider( sub {
    my $provider = shift;

    my $provider_name = $provider->id;
    if (@providers_filter) {
        return unless (grep { $_ eq $provider_name } @providers_filter);
    }

    my @instruments = ($instruments_txt ? split(/,/, $instruments_txt) : $provider->getAllInstruments());

    my @lines;
    foreach my $instrument (@instruments) {
        foreach my $tf (@$timeframes) {
            my $tableName = $provider->getTableName($instrument, $tf);
            my $s = $template;
            $s =~ s/TABLE_NAME/$tableName/g;
            $s =~ s/INSTRUMENT_NAME/$instrument/g;
            $s =~ s/TIMEFRAME_NAME/$tf/g;
            push @lines, $s;
        }
    }
    $prefix =~ s/PROVIDER_NAME/$provider_name/g;
    print $prefix, join($join, @lines), $suffix;
});



