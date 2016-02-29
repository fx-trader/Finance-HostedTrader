#!/usr/bin/perl

# ABSTRACT: Rudimentary database client, reads queries from STDIN and submits them to the fx database. Useful to run in docker containers where the mysql client is not available.

# PODNAME: fx-db-client.pl

=head1 SYNOPSIS
    fx-all-tables.pl | fx-db-client.pl


=cut


use strict;
use warnings;

use Finance:;HostedTrader::Datasource;


my $dbh = Finance::HostedTrader::Datasource->new()->{_dbh};

while (<STDIN>) {
    chomp();
    $dbh->do($_) or die($dbh->errstr);
}
