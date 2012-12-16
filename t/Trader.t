#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 9;
use Test::Exception;
use Data::Dumper;
use File::Basename;

BEGIN {
use_ok ('Finance::HostedTrader::Trader');
}
use Finance::HostedTrader::System;
use Finance::HostedTrader::Factory::Account;

my $t_path = dirname($0);

my $trendfollow = Finance::HostedTrader::System->new( name => 'trendfollow', pathToSystems => "$t_path/systems" );
my $usd_account = Finance::HostedTrader::Factory::Account->new( SUBCLASS => 'UnitTest', system => $trendfollow, startDate=> '2011-11-04', baseCurrency => 'USD' )->create_instance();
my $trader = Finance::HostedTrader::Trader->new( system => $trendfollow, account => $usd_account );
isa_ok($trader, 'Finance::HostedTrader::Trader');

is($trader->getEntryValue('EURUSD', 'long'), 1.3804, 'getEntryValue long');
is($trader->getEntryValue('EURUSD', 'short'), 1.3757, 'getEntryValue short');

is($trader->getExitValue('EURUSD', 'long'), '1.3584', 'getExitValue long');
is($trader->getExitValue('EURUSD', 'short'), 1.4249, 'getExitValue short');

diag("Testing convertToBaseCurrency");
is($usd_account->convertToBaseCurrency(10000, 'USD'), '10000', 'from USD to USD');
is($usd_account->convertToBaseCurrency(10000, 'JPY'), '128.1115', 'from JPY to USD');
is($usd_account->convertToBaseCurrency(10000, 'EUR'), '13830.0000', 'from EUR to USD');
