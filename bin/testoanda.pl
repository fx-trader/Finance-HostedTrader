#!/usr/bin/perl

use strict;
use warnings;

use Finance::HostedTrader::Provider::Oanda;
use Finance::HostedTrader::Provider::FXCM;


my $fxcm = Finance::HostedTrader::Provider::FXCM->new();

$fxcm->saveHistoricalDataToFile("/tmp/fxcm", "EURUSD", 60, 5000);

my $oanda = Finance::HostedTrader::Provider::Oanda->new();

$oanda->saveHistoricalDataToFile("/tmp/oanda", "CORNUSD", 60, 5000);
