#!/usr/bin/perl

eval 'exec /usr/bin/perl  -S $0 ${1+"$@"}'
    if 0; # not running under some shell
# ABSTRACT: Loads a datafile downloaded with fx-download-fxcm.pl into the database
# PODNAME: fx-load-datafile.pl


use strict;
use warnings;
$|=1;

use Getopt::Long;
use Finance::HostedTrader::Datasource;
use Pod::Usage;

my ($datafile, $help);

my $result = GetOptions(
    "datafile=s",    \$datafile,
    "help",         \$help)  or pod2usage(1);

pod2usage(1) if ( $help || !defined($datafile));

my $ds = Finance::HostedTrader::Datasource->new();
$ds->dbh->do("LOAD DATA LOCAL INFILE '$datafile' IGNORE INTO TABLE $datafile FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n'") or die($!);

__END__

=pod

=encoding UTF-8

=head1 NAME

fx-load-datafile.pl - Downloads historical data from fxcm, inserts it into local database.

=head1 VERSION

version 0.022

=head1 SYNOPSIS

    fx-load-datafile.pl --datafile=$filename

=head2 OPTIONS

=over

=item C<--datafile=$filename>

Required. The file to load into the database

=item C<--help>

Help screen

=back

=head1 AUTHOR

João Costa <joaocosta@zonalivre.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by João Costa.

This is free software, licensed under:

  The MIT (X11) License

=cut
