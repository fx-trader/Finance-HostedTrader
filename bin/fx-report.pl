#!/usr/bin/perl
# PODNAME: fx-report.pl
# ABSTRACT: Report on current system performance

=head1 SYNOPSIS

    fx-report.pl [--format=text|html]

=head1 DESCRIPTION

=head2 OPTIONS

=over 12

=item C<--format=s>

The output format of the report. Either 'text' or 'html'.

=item C<--help>

Display usage information.

=back

=head1 SEE ALSO

L<Finance::HostedTrader::Report>

=cut


use strict;
use warnings;

use Data::Dumper;
use Getopt::Long qw(:config pass_through);

use Finance::HostedTrader::Factory::Account;
use Finance::HostedTrader::Trader;
use Finance::HostedTrader::System;
use Finance::HostedTrader::Report;


my ($class, $format, $pathToSystems) = ('ForexConnect', 'text', 'systems');

GetOptions(
    "class=s"   => \$class,
    "format=s"  => \$format,
    "pathToSystems=s",  \$pathToSystems,
);


my $trendfollow = Finance::HostedTrader::System->new( name => 'trendfollow', pathToSystems => $pathToSystems );
my %classArgs = map { s/^--//; split(/=/) } @ARGV;
my $account = Finance::HostedTrader::Factory::Account->new( SUBCLASS => $class, %classArgs)->create_instance();
my $systemTrader = Finance::HostedTrader::Trader->new( system => $trendfollow, account => $account );
my $report = Finance::HostedTrader::Report->new( account => $account, systemTrader => $systemTrader, format => $format );
my $nav = $account->getNav();
my $balance = $account->balance();

print "<html><body><p>" if ($format eq 'html');
print "ACCOUNT NAV: " . $nav . "\n\n";
print "ACCOUNT BALANCE: " . $balance . "\n\n";
print "</p>" if ($format eq 'html');
print $report->openPositions;
print "\n";
print $report->systemEntryExit;
print "</body></html>" if ($format eq 'html');
