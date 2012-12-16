#!/usr/bin/perl
# ABSTRACT: Outputs the configuration that applies if when a Finance::HostedTrader script is run from the current working directory, including merging of multiple config files.
# PODNAME: fx-show-config.pl

use strict;
use warnings;

use Finance::HostedTrader::Config;
use Data::Dumper;

my $cfg = Finance::HostedTrader::Config->new();

if (@ARGV) {
    my @values;
    foreach my $key (@ARGV) {
        my @path = split('::', $key);
        my $ptr = $cfg;
        foreach (@path) {
            $ptr = $ptr->{$_};
        }
        push @values, $ptr;
    }
    print join(" ", @values);
} else {
    print Dumper(\$cfg);
}
