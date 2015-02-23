#!/usr/bin/perl
# ABSTRACT: Sets the subscription status of the input symbols to subscribed so that they show up in tradestation
# PODNAME: fx-setsubscription.pl

use strict;
use warnings;

use Finance::FXCM::Simple;
use Finance::HostedTrader::Config;

my $cfg = Finance::HostedTrader::Config->new();
my $providerCfg = $cfg->tradingProviders->{fxcm};
my $fxcm = Finance::FXCM::Simple->new($providerCfg->username, $providerCfg->password, $providerCfg->accountType, $providerCfg->serverURL);

foreach my $symbol (@ARGV) {
    print "Setting subscription for $symbol\n";
    $fxcm->setSubscriptionStatus($symbol, "T");
}
