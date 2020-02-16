#!/usr/bin/perl

# PODNAME: fx-adhoc.pl
# ABSTRACT: Sample adhoc examples

#!/usr/bin/perl

use strict;
use warnings;
use Finance::FXCM::Simple;
use Data::Printer;

    my $instrument = "AUD/USD";
    my $direction = "long";

    my $ff = Finance::FXCM::Simple->new(
                $ENV{FXCM_USER},
                $ENV{FXCM_PASSWORD},
                "Real",
                "http://www.fxcorporate.com/Hosts.jsp");

# Print AUD/USD trades only, sorted by open price
    my @trades = sort { $a->{openPrice} <=> $b->{openPrice} } grep { $_->{instrument} eq $instrument && $_->{direction} eq $direction } @{ $ff->getTrades };
    p @trades;

