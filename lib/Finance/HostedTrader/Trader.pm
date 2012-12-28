package Finance::HostedTrader::Trader;
# ABSTRACT: Finance::HostedTrader::Trader - 

use Finance::HostedTrader::Config;
use Finance::HostedTrader::Position;
use Finance::HostedTrader::System;

use Moose;
with 'MooseX::Log::Log4perl';
use List::Compare::Functional qw( get_intersection );
use Math::Round qw(nearest);

=attr C<system>
=cut
has 'system' => (
    is     => 'ro',
    isa    => 'Finance::HostedTrader::System',
    required=>1,
);

=attr C<account>
=cut
has 'account' => (
    is     => 'ro',
    isa    => 'Finance::HostedTrader::Account',
    required=>1,
);

=method C<getEntryValue>
=cut
sub getEntryValue {
    my $self = shift;

    return $self->_getSignalValue('enter', @_);
}

=method C<getExitValue>
=cut
sub getExitValue {
    my $self = shift;

    return $self->_getSignalValue('exit', @_);
}

sub _getSignalValue {
    my ($self, $action, $symbol, $tradeDirection) = @_;

    my $signal = $self->system->{signals}->{$action};

    return undef if (!defined($signal->{$tradeDirection}->{currentPoint}));

    return $self->account->getIndicatorValue(
                $symbol,
                $signal->{$tradeDirection}->{currentPoint},
                $signal->{args}
    );
}

=method C<checkEntrySignal>
=cut
sub checkEntrySignal {
    my $self = shift;

    return $self->_checkSignalWithAction('enter', 1, @_);
}

=method C<checkAddUpSignal>
=cut
sub checkAddUpSignal {
    my $self = shift;

    return $self->_checkSignalWithAction('add', 0, @_);
}

=method C<checkExitSignal>
=cut
sub checkExitSignal {
    my $self = shift;

    return $self->_checkSignalWithAction('exit', 1, @_);
}

sub _checkSignalWithAction {
    my ($self, $action, $required, $symbol, $tradeDirection) = @_;

    my $signal = $self->system->{signals}->{$action};
    return if (!$required && !$signal);
    $self->logger->logconfess("System definition file is missing entry signals->$action ") if (!defined($signal));
    my $signal_definition = $signal->{$tradeDirection};
    my $signal_args = $signal->{args};

    return $self->account->checkSignal(
                    $symbol,
                    $signal_definition->{signal},
                    $signal_args
    );
}


=method C<amountAtRisk($position)>

How much capital will be lost/gained if $ position closes at the stop loss
level defined by this system.

This returned value is relative to the opening price and does not take into
account current profit/loss.
=cut
sub amountAtRisk {
    my $self = shift;
    my $position = shift;
    my $account = $self->account;
    my $symbol = $position->symbol;

    my $size = $position->size();
    my $direction = ($size > 0 ? 'long' : 'short');
    my $stopLoss = $self->_getSignalValue('exit', $symbol, $direction);
    $self->logger->logconfess("Could not get stop loss for $symbol $direction") if (!defined($stopLoss));
    my $avgOpenPrice = $position->averagePrice();

    return 0 if (!$avgOpenPrice);

    my $pl = nearest(.0001, ( $avgOpenPrice - $stopLoss ) * $size);
    my $symbolBaseUnit = $account->getSymbolBase($symbol);

    return nearest(.0001, $account->convertToBaseCurrency($pl, $symbolBaseUnit, 'bid'));
}

=method C<getTradeSize>
=cut
sub getTradeSize {
my $self = shift;
my $symbol = shift;
my $direction = shift;
my $position = shift;

$position = Finance::HostedTrader::Position->new(symbol => $symbol) if (!defined($position));

my $maxLossPts;
my $system = $self->system;
my $trades = $position->getOpenTradeList;
my $numTrades = scalar(@$trades);
my $account = $self->account;
my $action = ( $numTrades == 0 ? 'enter' : 'add');
my $allowedExposure = $self->system->{signals}->{$action}->{$direction}->{exposure};

    if ($action eq 'add') {
        my $allowedNumTrades = scalar(@$allowedExposure);
        if ($numTrades > $allowedNumTrades) {
            $self->logger->info("No more trades allowed, have $numTrades, $allowedNumTrades max allowed");
            return (0,undef,undef);
        }
        $allowedExposure = $allowedExposure->[$numTrades-1];
    }
    $allowedExposure = $allowedExposure / 100;
    $self->logger->debug("Allowed exposure = $allowedExposure");

    my $balance = $account->balance();
    $self->logger->debug("Account balance = $balance");
    $self->logger->logconfess("balance is negative") if ($balance < 0);
    my $amountAtRisk = $self->amountAtRisk($position);
    $self->logger->debug("Amount at Risk = $amountAtRisk");
    my $existingExposure = nearest(.0001, $amountAtRisk / $balance);
    $self->logger->debug("Existing exposure = $existingExposure");

    my $maxExposure = $allowedExposure - $existingExposure;
    $self->logger->debug("Exposure for this trade = $maxExposure");
    return (0,undef,undef) if ($maxExposure <= 0);

    my $maxLossAmount   = $balance * $maxExposure;
    my $stopLoss = $self->_getSignalValue('exit', $symbol, $direction);
    $self->logger->logconfess("Could not get stop loss for $symbol $direction") if (!defined($stopLoss));
    my $base = $account->getSymbolBase($symbol);

    $self->logger->debug("Max acceptable loss in account currency = $maxLossAmount GBP");
    my $conversionFactor = 1;
    if ($base ne "GBP") { # TODO: should not be hardcoded that account is based on GBP
        $conversionFactor = $account->getAsk("GBP$base");
        $self->logger->logconfess("Could not retrieve current price for GBP$base") if (!defined($conversionFactor));
        $self->logger->debug("Conversion factor to trade currency= $conversionFactor");
        $maxLossAmount *= $conversionFactor;
    }

    my $value;
    if ($direction eq "long") {
        $value = $account->getAsk($symbol);
        $maxLossPts = $value - $stopLoss;
    } else {
        $value = $account->getBid($symbol);
        $maxLossPts = $stopLoss - $value;
    }

    $self->logger->debug("Max acceptable loss in trade currency = $maxLossAmount $base");
    $self->logger->debug("Current price ($symbol) = $value");
    $self->logger->debug("Stop loss price level ($symbol) = $stopLoss");

    if ( $maxLossPts <= 0 ) {
        $self->logger->logconfess("Tried to set stop to " . $stopLoss . " but current price is " . $value);
    }
    $self->logger->debug("Maximum loss points = $maxLossPts");
    my $tradeSize = $maxLossAmount / $maxLossPts;
    $self->logger->debug("Trade Size = $tradeSize");
    my $amount = $account->convertBaseUnit($symbol, $tradeSize);
    $self->logger->debug("Trade size converted to a multiple of broker's base unit = $amount");
    $self->logger->logconfess('Tried to open trade with negative amount. This should not happen unless there is a bug') if ($amount < 0);
    #my $maxLeveragePerTrade = 15; #TODO config setting
    #$self->logger->logconfess("Trade size too big, refusing\namount=$amount, baseCurrencyAmount=$baseCurrencyAmount, balance=$balance") if ( $baseCurrencyAmount > $balance * $maxLeveragePerTrade );
    return ($amount, $value, $stopLoss);
}

__PACKAGE__->meta->make_immutable;
1;
