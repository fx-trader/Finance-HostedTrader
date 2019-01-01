#!/usr/bin/perl
# ABSTRACT: Sets the subscription status of the input symbols to subscribed so that they show up in tradestation
# PODNAME: fx-setsubscription.pl

use strict;
use warnings;

use Finance::FXCM::Simple;
use Finance::HostedTrader::Config;

my $cfg = Finance::HostedTrader::Config->new();
my $providerCfg = $cfg->providers->{fxcm};
my $fxcm_user = $ENV{FXCM_USERNAME} || $providerCfg->username;
my $fxcm_pass = $ENV{FXCM_PASSWORD} || $providerCfg->password;
my $fxcm_accounttype = $ENV{FXCM_ACCOUNT_TYPE} || $providerCfg->accountType;

print "Connecting to fxcm account $fxcm_user ($fxcm_accounttype)\n";
my $fxcm = Finance::FXCM::Simple->new($fxcm_user, $fxcm_pass, $fxcm_accounttype, $providerCfg->serverURL);

foreach my $symbol (@ARGV) {
    print "Setting subscription for $symbol\n";
    $fxcm->setSubscriptionStatus($symbol, "T");
}
