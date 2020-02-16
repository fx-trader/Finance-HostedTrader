#!/usr/bin/perl
# ABSTRACT: Outputs descriptive statistics for a given instrument
# PODNAME: fx-stats.pl

=head1 SYNOPSIS

    fx-stats.pl [--timeframe=tf] [--instrument=s] [--max_loaded_items=i] [--item_count=i] [expr]

=cut

use strict;
use warnings;

use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Config;
use Finance::HostedTrader::ExpressionParser;

use Data::Dumper;
use Getopt::Long;
use Pod::Usage;

my ( $timeframe, $max_loaded_items, $max_display_items, $instrument, $help, $man ) =
  ( 'day', 180000, 625, 'GBPJPY', 0 );

GetOptions(
    "timeframe=s"           => \$timeframe,
    "instrument=s"          => \$instrument,
    "max_loaded_items=i"    => \$max_loaded_items,
    "item_count=i"          => \$max_display_items,
    "help|?"                => \$help,
    "man"                   => \$man,
) || pod2usage(2);
pod2usage(1) if ($help);
pod2usage(-exitval => 0, -verbose => 2) if ($man);

my $db  = Finance::HostedTrader::Datasource->new();
my $cfg = $db->cfg;
my $signal_processor = Finance::HostedTrader::ExpressionParser->new($db);


my $expression = $ARGV[0];

my $params = {
    'expression'        => $expression,
    'timeframe'         => $timeframe,
    'max_loaded_items'  => $max_loaded_items,
    'item_count'        => $max_display_items,
    'instrument'        => $instrument,
};

my $result = $signal_processor->getDescriptiveStatisticsData($params);

print Dumper($result->{stats});
print Dumper($result->{percentiles});
print Dumper($result->{average_returns});
print Dumper($result->{data});
