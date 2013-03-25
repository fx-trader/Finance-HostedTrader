#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 6;
use Data::Dumper;
use File::Basename;

use Finance::HostedTrader::Trader;
use Finance::HostedTrader::System;
use Finance::HostedTrader::Factory::Account;

my $t_path = dirname($0);
my $trendfollow = Finance::HostedTrader::System->new( name => 'trendfollow', pathToSystems => "$t_path/systems" );

{
    diag("Add two short trades and check balanceAtRisk");
    my $account = Finance::HostedTrader::Factory::Account->new(
                    SUBCLASS                => 'UnitTest',
                    system                  => $trendfollow,
                    startDate               => '2011-11-04',    # The simulated initial date
                    baseCurrency            => 'USD',           # balanceAtRisk will return values in the account's base currency
                    notifier                => undef,           # This test doesn't need a notifier, this should be off by default i guess
                    skipToDatesWithSignal   => 0,               # Don't want to skip to signal dates either, this should be off by default too
                    interval                => 604800,          # When waitForNextTrade is called, move forward this many seconds
                )->create_instance();
    my $trader = Finance::HostedTrader::Trader->new( system => $trendfollow, account => $account );

    $account->openMarket('EURUSD', 'short', 10000);
    is($account->getPosition('EURUSD')->balanceAtRisk($account, $trader->getExitValue('EURUSD', 'short')), 419, "Added short trade 1");
    $account->waitForNextTrade(); # move forward in time
    $account->openMarket('EURUSD', 'short', 20000);
    is($account->getPosition('EURUSD')->balanceAtRisk($account, $trader->getExitValue('EURUSD', 'short')), 1699, "Added short trade 2");
}

{
    diag("Add two long trades and check balanceAtRisk");
    my $account = Finance::HostedTrader::Factory::Account->new(
                    SUBCLASS                => 'UnitTest',
                    system                  => $trendfollow,
                    startDate               => '2011-11-04',    # The simulated initial date
                    baseCurrency            => 'USD',           # balanceAtRisk will return values in the account's base currency
                    notifier                => undef,           # This test doesn't need a notifier, this should be off by default i guess
                    skipToDatesWithSignal   => 0,               # Don't want to skip to signal dates either, this should be off by default too
                    interval                => 604800,          # When waitForNextTrade is called, move forward this many seconds
                )->create_instance();
    my $trader = Finance::HostedTrader::Trader->new( system => $trendfollow, account => $account );

    $account->openMarket('GBPUSD', 'long', 30000);
    is($account->getPosition('GBPUSD')->balanceAtRisk($account, $trader->getExitValue('GBPUSD', 'long')), 1485, "Added long trade");
    $account->waitForNextTrade(); # move forward in time
    $account->openMarket('GBPUSD', 'long', 20000);
    is($account->getPosition('GBPUSD')->balanceAtRisk($account, $trader->getExitValue('GBPUSD', 'long')), 1587, "Added long trade");
}

{
    diag("Add one long and one short trade and check balanceAtRisk");
    my $account = Finance::HostedTrader::Factory::Account->new(
                    SUBCLASS                => 'UnitTest',
                    system                  => $trendfollow,
                    startDate               => '2011-11-04',    # The simulated initial date
                    baseCurrency            => 'USD',           # balanceAtRisk will return values in the account's base currency
                    notifier                => undef,           # This test doesn't need a notifier, this should be off by default i guess
                    skipToDatesWithSignal   => 0,               # Don't want to skip to signal dates either, this should be off by default too
                    interval                => 604800,          # When waitForNextTrade is called, move forward this many seconds
                )->create_instance();
    my $trader = Finance::HostedTrader::Trader->new( system => $trendfollow, account => $account );

    $account->openMarket('GBPUSD', 'long', 30000);
    is($account->getPosition('GBPUSD')->balanceAtRisk($account, $trader->getExitValue('GBPUSD', 'long')), 1485, "Added long trade");
    $account->waitForNextTrade(); # move forward in time
    $account->openMarket('GBPUSD', 'short', 20000);

    is($account->getPosition('GBPUSD')->balanceAtRisk($account, $trader->getExitValue('GBPUSD', 'long')), 555, "Added short trade");
}
