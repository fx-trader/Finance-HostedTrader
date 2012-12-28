#!/usr/bin/perl
# PODNAME: fx-trader.pl
# ABSTRACT: Real time trading service

use strict;
use warnings;
$| = 1;
use Getopt::Long qw(:config pass_through);
use Data::Dumper;
use Pod::Usage;

use Log::Log4perl;
BEGIN{
    if ( -r "/etc/fxtrader/fxtrader.log.conf" ) {
        Log::Log4perl->init("/etc/fxtrader/fxtrader.log.conf");
    }
}

use Finance::HostedTrader::Factory::Account;
use Finance::HostedTrader::Trader;
use Finance::HostedTrader::System;
use Finance::HostedTrader::Report;

my ($verbose, $help, $accountClass, $pathToSystems, $systemName) = (0, 0, 'ForexConnect', 'systems', 'trendfollow');

my $result = GetOptions(
    "class=s",          \$accountClass,
    "verbose",          \$verbose,
    "help",             \$help,
    "pathToSystems=s",  \$pathToSystems,
    "systemName=s",     \$systemName,
) || pod2usage(2);

pod2usage(1) if ($help);


my $system = Finance::HostedTrader::System->new( name => $systemName, pathToSystems => $pathToSystems );

my %classArgs = map { s/^--//; split(/=/) } @ARGV;
foreach (keys %classArgs) {
    $classArgs{$_} = undef if ($classArgs{$_} eq 'undef');
}

my $account = Finance::HostedTrader::Factory::Account->new(
                SUBCLASS => $accountClass,
                system => $system,
                %classArgs,
            )->create_instance();

my @systems =   (
                    Finance::HostedTrader::Trader->new(
                        system => $system,
                        account => $account,
                    ),
                );

logger("STARTUP") if ($verbose);

foreach my $system (@systems) {
    logger("Loaded system " . $system->system->name) if ($verbose);
}

my $systemTrader = $systems[0];
while (1) {
    # test the system
    eval {
        checkSystem($account, $systemTrader, 'long');
        1;
    } or do {
        logger($@);
    };

    eval {
        checkSystem($account, $systemTrader, 'short');
        1;
    } or do {
        logger($@);
    };

    my ($previousTime, $currentTime);
    # get current time
    $previousTime = substr($account->getServerDateTime, 0, 10) if ($verbose);
    # sleep for a bit
    $account->waitForNextTrade();
    if ($verbose > 1 && 0) {
        # print a report if the day changed
        $currentTime = substr($account->getServerDateTime, 0, 10) if ($verbose);
        my $report = Finance::HostedTrader::Report->new( account => $account, systemTrader => $systemTrader );
        logger("NAV = " . $account->getNav) if ($previousTime ne $currentTime);
        logger("\n".$report->openPositions) if ($previousTime ne $currentTime);
        logger("\n".$report->systemEntryExit) if ($previousTime ne $currentTime);
    }
    if ( $account->getServerDateTime() gt $account->endDate ) {
        if ($verbose) {
            my $report = Finance::HostedTrader::Report->new( account => $account, systemTrader => $systemTrader );
            logger("Final report");
            logger("NAV = " . $account->getNav);
            logger("\n".$report->openPositions);
            logger("\n".$report->systemEntryExit);
        }
        last;
    }
}

sub checkSystem {
    my ($account, $systemTrader, $direction) = @_;

    my $symbols = $systemTrader->system->symbols($direction);

    foreach my $symbol ( @$symbols ) {
        my $position = $account->getPosition($symbol);
        my $posSize = $position->size;

        my $result;
        my $signal_type;
        if ($posSize == 0) {
            logger("Checking ".$systemTrader->system->name." $symbol $direction") if ($verbose > 2);
            $result = $systemTrader->checkEntrySignal($symbol, $direction);
            $signal_type = 'entry';
        } else {
            logger("Checking ".$systemTrader->system->name." $symbol $direction") if ($verbose > 2);
            $result = $systemTrader->checkAddUpSignal($symbol, $direction);
            $signal_type = 'add';
        }

        if ($result) {
            logger("Found $signal_type signal: " . Dumper(\$result)) if ($verbose);
            my ($amount, $value, $stopLoss) = $systemTrader->getTradeSize($symbol, $direction, $position);
            if ($verbose > 2 && $result) {
                logger("$symbol $direction at " . $result->[0] . " Amount=" . $amount . " value=" . $value . " stopLoss=" . $stopLoss);
            }
            next if ($amount <= 0);
            my $report;
            if ($verbose) {
                $report = Finance::HostedTrader::Report->new( account => $account, systemTrader => $systemTrader );
                logger("Positions before open trade");
                logger("NAV=" . $account->getNav());
                logger($report->openPositions);
                logger($report->systemEntryExit);
                logger("Adding position for $symbol $direction ($amount)");
            }

            $account->openMarket($symbol, $direction, $amount, $stopLoss);

            if ($verbose) {
                logger("Positions after open trade");
                logger("NAV=" . $account->getNav());
                logger($report->openPositions);
                logger($report->systemEntryExit);
            }
        } elsif ( $posSize ) {
            my $result = $systemTrader->checkExitSignal($symbol, $direction);
            if ($result) {
                logger("Found exit signal: " . Dumper(\$result));
                my $report;
                if ($verbose) {
                    $report = Finance::HostedTrader::Report->new( account => $account, systemTrader => $systemTrader );
                    logger("Positions before close trades");
                    logger("NAV=" . $account->getNav());
                    logger($report->openPositions);
                    logger($report->systemEntryExit);
                    logger("Closing position for $symbol $direction ( $posSize )");
                }
                $account->closeTrades($symbol, $direction);
                if ($verbose) {
                    logger("Positions after close trades");
                    logger("NAV=" . $account->getNav());
                    logger($report->openPositions);
                    logger($report->systemEntryExit);
                }
            }
        }
    }

}

sub logger {
    my $msg = shift;

    my $datetimeNow = $account->getServerDateTime;
    print "[$datetimeNow] $msg\n";
}
