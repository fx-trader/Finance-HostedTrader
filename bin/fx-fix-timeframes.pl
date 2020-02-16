#!/usr/bin/perl

eval 'exec /usr/bin/perl  -S $0 ${1+"$@"}'
    if 0; # not running under some shell
# ABSTRACT: Useful to rebuild timeframes for given instruments
# PODNAME: fx-fix-timeframes.pl


use strict;
use warnings;
$|=1;

use Getopt::Long;
use Finance::HostedTrader::Config;
use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Synthetics;
use Pod::Usage;
use Try::Tiny;


my ( $verbose, $help ) = ( 0, 0 );
my (@instruments, @timeframes);

my $result = GetOptions(
    "instruments=s",    \@instruments,
    "timeframes=s",     \@timeframes,
    "verbose",          \$verbose,
    "help",             \$help)  or pod2usage(1);

pod2usage(1) if ( $help );

my $cfg         = Finance::HostedTrader::Config->new();

@instruments = split(/,/, join(',', @instruments));
@timeframes = split(/,/, join(',', @timeframes));

@timeframes = @{ $cfg->timeframes->all } unless(@timeframes);


my @tfs     = sort { $a <=> $b } @{ $cfg->timeframes->all() };
my $lowerTf = shift (@tfs);

my $ds = Finance::HostedTrader::Datasource->new();

$ds->cfg->forEachProvider( sub {
    my $p = shift;

    my @provider_instruments = (@instruments ? @instruments : $p->getInstruments());
    foreach my $instrument (@provider_instruments) {
        foreach my $tf (@tfs) {
            next unless (grep(/^$tf$/,@timeframes));
            print "Updating " . $p->id . " $instrument $tf synthetic\n" if ($verbose);
            my $select_sql = Finance::HostedTrader::Synthetics::get_synthetic_timeframe(provider => $p, instrument => $instrument, timeframe => $tf );
            my $table = $p->getTableName($instrument, $tf);

            my $sql = qq/REPLACE INTO $table
            $select_sql/;

            $ds->dbh->do($sql) or die($!);
        }
    }
});


__END__

=pod

=encoding UTF-8

=head1 NAME

fx-fix-timeframes.pl - Rebuilds timeframe tables for one or more instruments

=head1 VERSION

version 0.022

=head1 SYNOPSIS

    fx-fix-timeframes.pl --instruments=[SYM1,[SYM2,...]] --timeframes=[TF1,[TF2],...] [--verbose] [--help]

=head2 OPTIONS

=over

=item C<--instruments=[$SYM1[,$SYM2 ...]]>

Optional. A comma separated string of instrument codes. See L<Finance::HostedTrader::Config::Symbols> for available codes.  Defaults to all available instruments.

=item C<--timeframes=[$TF1[,$TF2 ...]]>

Optional. A comma separated string of timeframe codes. See L<Finance::HostedTrader::Config::Symbols> for available codes.  Defaults to all available timeframes.

=item C<--verbose>

Verbose output

=item C<--help>

Help screen

=back

=cut
