#!/usr/bin/perl
# ABSTRACT: Generates statments which can be used against all symbols/timeframes
# PODNAME: fx-all-tables.pl

=head1 SYNOPSIS

    fx-all-tables.pl [--template "TRUNCATE TABLE TABLE_NAME" --timeframes=$TF1[,$TF2] --symbols=EURUSD,[GBPUSD]]

=head2 OPTIONS

=over

=item C<--timeframes=$TF1[,$TF2 ...]>

Optional. A comma separated string of timeframe codes for which data is to be downloaded.
See L<Finance::HostedTrader::Config::Timeframes> for available codes.
Defaults to all timeframes defined in /etc/fxtrader/fx.yml .

=item C<--symbols=s>

Optional. A comma separated string of symbols to process.
Defaults to all symbols defined in /etc/fxtrader/fx.yml .

=item C<--template=s>

Optional, but most likely fundamental.  The template for what statment will be output.
The string "TABLE_NAME" will be replaced by the name of the db table that supports a given symbol/timeframe.
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

my ($template,$timeframes_txt, $symbols_txt, $help) = ('TABLE_NAME');

my $result = GetOptions(
                        "timeframes=s", \$timeframes_txt,
                        "symbols=s", \$symbols_txt,
                        "template=s", \$template,
                        "help", \$help,
                    )  or pod2usage(1);

pod2usage(1) if ( $help );

my $db = Finance::HostedTrader::Datasource->new();

my $symbols;
if (!defined($symbols_txt)) {
    $symbols = $db->cfg->provider->getAllInstruments();
} elsif ($symbols_txt eq 'natural') {
    $symbols = $db->cfg->symbols->natural;
} elsif ($symbols_txt eq 'synthetics') {
    $symbols = $db->cfg->symbols->synthetic_names;
} else {
    $symbols = [split(',',$symbols_txt)] if ($symbols_txt);
}

my $timeframes = $db->cfg->timeframes->all;
$timeframes = [split(',',$timeframes_txt)] if ($timeframes_txt);


foreach my $symbol (@{$symbols}) {
foreach my $tf (@$timeframes) {
next if ($tf == 60);
my $tableName = $symbol.'_'.$tf;
my $s = $template;
$s =~ s/TABLE_NAME/$tableName/g;
print $s,"\n";
}
}
