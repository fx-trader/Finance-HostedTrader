#!/usr/bin/perl

use strict;
use warnings;

use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Config;
use Finance::HostedTrader::ExpressionParser;

use Data::Dumper;

my $db  = Finance::HostedTrader::Datasource->new();
my $cfg = $db->cfg;
my $signal_processor = Finance::HostedTrader::ExpressionParser->new($db);


my $timeframe           = 'day';
my $instrument          = 'GBPJPY';
my $max_display_items   = 625;
my $max_loaded_items    = 180000;

my $params = {
    'timeframe'         => $timeframe,
    'max_loaded_items'  => $max_loaded_items,
    'item_count'        => $max_display_items,
    'symbol'            => $instrument,
};

my $result = $signal_processor->getDescriptiveStatisticsData($params);

print Dumper($result->{stats});
print Dumper($result->{percentiles});
