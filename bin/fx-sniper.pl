#!/usr/bin/perl

use strict;
use warnings;

package main;

use Log::Log4perl;
use List::Util qw(sum);

use Finance::HostedTrader::ExpressionParser;
use Finance::FXCM::Simple;

# Initialize Logger
my $log_conf = q(
log4perl rootLogger = DEBUG, LOG1, SCREEN
log4perl.appender.SCREEN         = Log::Log4perl::Appender::Screen
log4perl.appender.SCREEN.stderr  = 0
log4perl.appender.SCREEN.layout  = Log::Log4perl::Layout::PatternLayout
log4perl.appender.SCREEN.layout.ConversionPattern = %d{ISO8601} %m %n
log4perl.appender.LOG1 = Log::Log4perl::Appender::File
log4perl.appender.LOG1.filename = ./sniper.log
log4perl.appender.LOG1.mode = append
log4perl.appender.LOG1.layout = Log::Log4perl::Layout::PatternLayout
log4perl.appender.LOG1.layout.ConversionPattern = %d{ISO8601} %p %M{2} %m %n
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

my $symbol = "AUDUSD";          # The symbol to trade in
my $fxcm_symbol = "AUD/USD";    # Finance::FXCM::Simple only knows about FXCM symbols which have a different format than Finance::HostedTrader symbols
my $max_exposure = 50000;       # Maximum amount I'm willing to buy/sell in $symbol
my $exposure_increment = 1000;  # How much more do I want to buy each time
my $check_interval = 5;        # How many seconds to wait for before checking again if it's time to buy

while (1) {
    last if ( -f "/tmp/sniper_disengage" );

    sleep($check_interval);

    my $data = getIndicatorValue($symbol, '4hour', "macd(close, 12, 26, 9) - macdsig(close, 12, 26, 9)");
    $logger->debug("Skip") and next if ($data->[1] >= 0);

    $data = getIndicatorValue($symbol, '5min', "rsi(close,14)");
    $logger->debug("Skip") and next if ($data->[1] >= 35);

    my $fxcm = Finance::FXCM::Simple->new($ENV{FXCM_USERNAME}, $ENV{FXCM_PASSWORD}, 'Real', 'http://www.fxcorporate.com/Hosts.jsp');
    my $symbol_trades = $fxcm->getTradesForSymbol($fxcm_symbol);
    my $symbol_exposure = sum map { $_->{direction} eq 'long' ? $_->{size} : $_->{size} * (-1) }  @$symbol_trades;

    my @trades = sort { $b->{openDate} cmp $a->{openDate} } grep { $_->{direction} eq 'long' } @{ $symbol_trades || [] };
    $logger->debug("LAST TRADE = " . $trades[0]->{openPrice}) if ( $trades[0]);
    $logger->debug("ASK = " . $fxcm->getAsk($fxcm_symbol)); # The price I can buy at

    my $latest_price = $fxcm->getAsk($fxcm_symbol);
    $logger->debug("Skip") and next if ( $trades[0] && ( $latest_price < $trades[0]->{openPrice} - 25 ) );

    $logger->debug("Max Exposure = $max_exposure");
    $logger->debug("Current Exposure = $symbol_exposure");
    $logger->debug("Increment = $exposure_increment");
    $logger->debug("Skip") and next if ( $max_exposure < $symbol_exposure + $exposure_increment);

    $logger->debug("Should we buy $exposure_increment here ?");

    $fxcm = undef; #This logouts from the FXCM session, and can take a few seconds to return
}

sub getIndicatorValue {
    my $symbol = shift;
    my $tf = shift;
    my $indicator = shift;

    my $signal_processor = Finance::HostedTrader::ExpressionParser->new(); # This object knows how to calculate technical indicators
    my $data = $signal_processor->getIndicatorData( {
            'fields'          => "datetime,$indicator",
            'symbol'          => $symbol,
            'tf'              => $tf,
            'maxLoadedItems'  => 5000,
            'numItems' => 1,
        });
    $signal_processor = undef;
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
