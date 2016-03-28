#!/usr/bin/perl

# ABSTRACT: Rudimentary database client, reads queries from STDIN and submits them to the fx database. Useful to run in docker containers where the mysql client is not available.

# PODNAME: fx-db-client.pl

=head1 SYNOPSIS
    fx-create-db-schema.pl | fx-db-client.pl
    fx-all-tables.pl --template "OPTIMIZE TABLE TABLE_NAME;" | fx-db-client.pl
=cut


use strict;
use warnings;

use Finance::HostedTrader::Datasource;


my $dbh = Finance::HostedTrader::Datasource->new()->dbh;
$dbh->{RaiseError} = 0;

my $query_buffer='';
while (<STDIN>) {
    chomp();
    next unless ($_);

    $query_buffer .= $_;
    if ($query_buffer =~ /;$/) {
        $dbh->do($query_buffer) or die("Error Running Query:\n======\n$query_buffer\n=====\n\n" . $dbh->errstr);
        $query_buffer='';
    }
}
