#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 10;
use Test::Exception;
use Data::Dumper;

BEGIN {
use_ok ('Finance::HostedTrader::Config::Symbols');
}

my $empty_tfs = Finance::HostedTrader::Config::Symbols->new(
	'natural' => [],
	'synthetic' => undef,
	);

is_deeply($empty_tfs->natural, [], 'Natural symbols empty');
is_deeply($empty_tfs->synthetic, [], 'Synthetic symbols empty');
is_deeply($empty_tfs->all, [], 'All symbols empty');

my $non_empty_tfs = Finance::HostedTrader::Config::Symbols->new(
	'natural' => [ 'AUDUSD', 'USDJPY' ],
	'synthetic' => [ { name => 'GER30USD'} ],
	);

is_deeply($non_empty_tfs->natural, ['AUDUSD','USDJPY'], 'Natural symbols non empty');
is_deeply($non_empty_tfs->synthetic_names, ['GER30USD'], 'Synthetic symbols non empty');
is_deeply($non_empty_tfs->all, ['AUDUSD','USDJPY','GER30USD'], 'All symbols non empty');

is_deeply( $non_empty_tfs->get_symbols_by_denominator("USD"), ['AUDUSD','GER30USD'], 'All symbols with denominator USD');
is_deeply( $non_empty_tfs->get_symbols_by_denominator("JPY"), ['USDJPY'], 'All symbols with denominator JPY');

is_deeply( $non_empty_tfs->get_symbols_by_numerator("AUD"), [qw/AUDUSD/], 'All symbols with numerator AUD');
