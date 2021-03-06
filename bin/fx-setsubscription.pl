#!/usr/bin/perl
# ABSTRACT: Sets the subscription status of the input instruments to subscribed so that they show up in tradestation
# PODNAME: fx-setsubscription.pl

use strict;
use warnings;

use Finance::FXCM::Simple;
use Finance::HostedTrader::Config;

my $cfg = Finance::HostedTrader::Config->new();
my $provider = $cfg->providers->{fxcm};
my $fxcm_user = $ENV{FXCM_USERNAME} || $provider->username;
my $fxcm_pass = $ENV{FXCM_PASSWORD} || $provider->password;
my $fxcm_accounttype = $ENV{FXCM_ACCOUNT_TYPE} || $provider->accountType;

print "Connecting to fxcm account $fxcm_user ($fxcm_accounttype)\n";
my $fxcm = Finance::FXCM::Simple->new($fxcm_user, $fxcm_pass, $fxcm_accounttype, $provider->serverURL);

foreach my $instrument (@ARGV) {
    print "Setting subscription for $instrument\n";
    $fxcm->setSubscriptionStatus($instrument, "T");
}
