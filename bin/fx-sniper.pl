#!/usr/bin/perl

use strict;
use warnings;

package main;

use Log::Log4perl;

use Finance::HostedTrader::ExpressionParser;
use Finance::FXCM::Simple;

# Initialize Logger
my $log_conf = q(
log4perl rootLogger = DEBUG, LOG1, SCREEN
log4perl.appender.SCREEN         = Log::Log4perl::Appender::Screen
log4perl.appender.SCREEN.stderr  = 0
log4perl.appender.SCREEN.layout  = Log::Log4perl::Layout::PatternLayout
log4perl.appender.SCREEN.layout.ConversionPattern = %d %m %n
log4perl.appender.LOG1 = Log::Log4perl::Appender::File
log4perl.appender.LOG1.filename = ./sniper.log
log4perl.appender.LOG1.mode = append
log4perl.appender.LOG1.layout = Log::Log4perl::Layout::PatternLayout
log4perl.appender.LOG1.layout.ConversionPattern = %d %p %m %n
);
Log::Log4perl::init(\$log_conf);
my $logger = Log::Log4perl->get_logger();

my %rules = (
    'AUDUSD buy' => {
        symbol  => 'AUDUSD',
        filters => [
            {
                class => "Sniper::Filter::Expression",
                args  => {
                    tf         => '4hour',
                    expression => 'macdsignal < 0'
                },
            },
            {
                class => "Sniper::Filter::Expression",
                args  => {
                    tf         => '5min',
                    expression => 'rsi(close,14) < 35'
                },
            },
            {
                class => "Sniper::Filter::ExistingTrade",
                args  => {
                    points => 40
                },
            },
        ],
        actions => [
            {
                class => "Sniper::Action::Trade",
                args  => {
                    amount    => 1000,
                    direction => 'B',
                },
            },
        ],
    }
);

$logger->logdie("FXCM_USERNAME NOT DEFINED") if (!$ENV{FXCM_USERNAME});
$logger->logdie("FXCM_PASSWORD NOT DEFINED") if (!$ENV{FXCM_PASSWORD});

my $symbol = "AUDUSD";
my $fxcm_symbol = "AUD/USD";
my $signal_processor = Finance::HostedTrader::ExpressionParser->new();


while (1) {
    last if ( -f "/tmp/sniper_disengage" );

    sleep(3);

    my $data = getIndicatorValue($symbol, '4hour', "macd(close, 12, 26, 9) - macdsig(close, 12, 26, 9)");
    $logger->debug("Skip") and next if ($data->[1] >= 0);

    $data = getIndicatorValue($symbol, '5min', "rsi(close,14)");
    $logger->debug("Skip") and next if ($data->[1] >= 65);

    my $fxcm = Finance::FXCM::Simple->new($ENV{FXCM_USERNAME}, $ENV{FXCM_PASSWORD}, 'Real', 'http://www.fxcorporate.com/Hosts.jsp');
    my @trades = sort { $b->{openPrice} <=> $a->{openPrice} } grep { $_->{symbol} eq $fxcm_symbol && $_->{direction} eq 'long' } @{ $fxcm->getTrades() || [] };

    $logger->debug("LAST TRADE = " . $trades[0]->{openPrice}) if ($trades[0]);
    $logger->debug("ASK = " . $fxcm->getAsk($fxcm_symbol));
    $logger->debug("BID = " . $fxcm->getBid($fxcm_symbol));

    $fxcm = undef;

    $logger->debug("Should we buy here ?");

}

sub getIndicatorValue {
    my $symbol = shift;
    my $tf = shift;
    my $indicator = shift;

    my $data = $signal_processor->getIndicatorData( {
            'fields'          => "datetime,$indicator",
            'symbol'          => $symbol,
            'tf'              => $tf,
            'maxLoadedItems'  => 5000,
            'numItems' => 1,
        });
    $logger->logdie("Failed to retrieve indicator '$indicator'") if (!$data || !$data->[0]);
    $logger->debug("[$data->[0]->[0]] $indicator = $data->[0]->[1]");

    return $data->[0];
}

unlink("/tmp/sniper_disengage");

1;

package Sniper::Filter::Expression;


sub new {
    my ( $class, $args ) = @_;
    return bless {%$args}, $class;
}

sub check {
    my ( $self, $symbol ) = @_;

    my $description = join(", ", map { "$_ = $self->{$_}" } sort keys %$self);
    $logger->debug("Check $symbol with options $description");
    return rand(100) > 50;
}

1;

package Sniper::Filter::ExistingTrade;

sub new {
    my ( $class, $args ) = @_;
    return bless {%$args}, $class;
}

sub check {
    my ( $self, $symbol ) = @_;

    my $description = join(", ", map { "$_ = $self->{$_}" } sort keys %$self);
    $logger->debug("Check $symbol with options $description");
    return rand(100) > 50;
}

1;

package Sniper::Action::Trade;

sub new {
    my ( $class, $args ) = @_;
    return bless {%$args}, $class;
}

sub do {
    my ( $self, $symbol ) = @_;

    my $description = join(", ", map { "$_ = $self->{$_}" } sort keys %$self);
    $logger->debug("Check $symbol with options $description");
    return rand(100) > 50;
}

1;
