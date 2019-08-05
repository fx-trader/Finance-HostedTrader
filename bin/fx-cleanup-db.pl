#!/usr/bin/perl
# ABSTRACT: Deletes old data and optimizes tables
# PODNAME: fx-cleanup-db.pl

=head1 SYNOPSIS

    fx-cleanup-db.pl [--providers=oanda,[fxcm]]

=head2 OPTIONS

=over

=item C<--providers=s>

Optional. A comma separated string of providers database tables to cleanup.
Defaults to oanda.

=item C<--help>

Help screen

=back

=cut



use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use Finance::HostedTrader::Datasource;

my ($providers_txt,$timeframes_txt, $instruments_txt, $help) = ('oanda');

my $result = GetOptions(
                        "providers=s", \$providers_txt,
                        "help", \$help,
                    )  or pod2usage(1);

pod2usage(1) if ( $help );

my $db = Finance::HostedTrader::Datasource->new();


my %records_to_keep_in_timeframe = (
    60  => 20000,
);

my $timeframes = $db->cfg->timeframes->all;
$timeframes = [split(',',$timeframes_txt)] if ($timeframes_txt);

my @providers_filter = split(/,/, $providers_txt);

$db->cfg->forEachProvider( sub {
    my $provider = shift;

    if (@providers_filter) {
        return unless (grep { $_ eq $provider->id } @providers_filter);
    }

    my @instruments = ($instruments_txt ? split(/,/, $instruments_txt) : $provider->getAllInstruments());

    foreach my $instrument (@instruments) {
        foreach my $tf (@$timeframes) {
            my $records_to_keep = $records_to_keep_in_timeframe{$tf} // 5000;
            my $tableName = $provider->getTableName($instrument, $tf);
            my $cleanup_sql = "DELETE FROM $tableName 
                WHERE datetime NOT IN (
                SELECT datetime
                FROM (
                    SELECT datetime
                    FROM $tableName
                    ORDER BY datetime DESC
                    LIMIT $records_to_keep
                ) foo
                );
            ";
            print "Cleaning $instrument $tf\n";
            $db->dbh->do($cleanup_sql);
            print "Optimizing $instrument $tf\n";
            $db->dbh->do("OPTIMIZE TABLE $tableName");
        }
    }
});



