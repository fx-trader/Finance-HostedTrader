package Finance::HostedTrader::Account;
# ABSTRACT: Finance::HostedTrader::Account - Account object

=head1 SYNOPSIS

    use Finance::HostedTrader::Account;
    my $obj = Finance::HostedTrader::Account->new(
                );

=cut


use Moose;
with 'MooseX::Log::Log4perl';
use Finance::HostedTrader::ExpressionParser;
use Finance::HostedTrader::Position;

use Date::Manip;


##These should exist everywhere, regardless of broker

=attr C<startDate>

The time the trading system starts trading

=cut
has startDate => (
    is     => 'rw',
    isa    => 'Str',
    required=>1,
    default => 'now',
);

=attr C<endDate>

The time the trading system stops trading

=cut
has endDate => (
    is     => 'rw',
    isa    => 'Str',
    required=>1,
    default => '-10 years ago',
);

=attr C<notifier>
=cut
has 'notifier' => (
    is      => 'ro',
    isa     => 'Maybe[Finance::HostedTrader::Trader::Notifier]',
    required=> 1,
);

has '_signal_processor' => (
    is      => 'ro',
    isa     => 'Finance::HostedTrader::ExpressionParser',
    lazy    => 1,
    builder => '_build_signal_processor',
);

sub _build_signal_processor {
    my $self = shift;
    $self->logger->trace("Lazy build ExpressionParser");
    return Finance::HostedTrader::ExpressionParser->new();
}


=method C<BUILD>

Constructor.

Converts {start,end}Date to 'YYYY-MM-DD hh:mm:ss' format using L<Date::Manip> UnixDate.

Validates dates.
=cut
sub BUILD {
    my $self = shift;

    $self->logger->trace("Build new " . __PACKAGE__);

    my $startDate = UnixDate($self->startDate, '%Y-%m-%d %H:%M:%S');
    die("Invalid date format: " . $self->startDate) if (!$startDate);
    my $endDate = UnixDate($self->endDate, '%Y-%m-%d %H:%M:%S');
    die("Invalid date format: " . $self->endDate) if (!$endDate);
    die("End date cannot be earlier than start date") if ( $endDate lt $startDate);
    $self->startDate($startDate);
    $self->endDate($endDate);
    $self->logger->info("startDate = $startDate");
    $self->logger->info("endDate = $endDate");
    $self->{_positions} = {};
    $self->{_lastRefreshPositions} = 0;
}

=method C<refreshPositions()>

This method must be overriden. It updates $self->{_positions} with an hash ref keyed by symbol with a L<Finance::HostedTrader::Position> object as value.

This method will typically have to read existing positions from the Account provider (eg: L<Finance::HostedTrader::Account::FXCM::ForexConnect>)
and store them in the Account object for local access.

It gets called by getPosition and getPositions


=cut
sub refreshPositions {
    my $self = shift;
    $self->logger->logcroak("refreshPositions must be overriden");
}

=method C<getAsk($symbol)>

This method must be overriden. Returns the current ask price for $symbol.

=cut
sub getAsk {
    my $self = shift;
    $self->logger->logcroak("getAsk must be overriden");
}

=method C<getBid>

This method must be overriden. Returns the current bid price for $symbol.

=cut
sub getBid {
    my $self = shift;
    $self->logger->logcroak("getBid must be overriden");
}

=method C<openMarket($symbol, $direction, $amount>

This method must be overriden. Opens a trade in $symbol at current market price.

$direction can be either 'long' or 'short'

If a notifier has been defined, the L<Finance::HostedTrader::Notifier> open method is called after the trade is open.

=cut
sub openMarket {
    my ($self, $symbol, $direction, $amount) = @_;
    $self->logger->info("openMarket $symbol $direction $amount");
    inner();
    $self->{_lastRefreshPositions} = 0; # Force retrieving fresh position list from server on next call to getPositions

    my $notifier = $self->notifier();
    if ($notifier) {
        $notifier->open(
            symbol      => $symbol,
            direction   => $direction,
            amount      => $amount, 
            now         => $self->getServerDateTime(),
            nav         => $self->getNav(),
            balance     => $self->balance(),
        );
    }
}

=method C<closeMarket($tradeID, $amount)>

This method must be overriden. Closes a trade at current market price.

$tradeID is returned when calling openMarket(). It can also be retrieved via getTrades().

Returns $closedTradeID

=cut
sub closeMarket {
    my ($self, $tradeID, $amount) = @_;
    $self->logger->info("closeMarket $tradeID $amount");
    my $rv = inner();
    $self->{_lastRefreshPositions} = 0; # Force retrieving fresh position list from server on next call to getPositions
    return $rv;
}

=method C<getBaseUnit($symbol)>

This method must be overriden. Returns the base unit at which the symbol trades.

Eg, if baseUnit=10000, the symbol can only trade in multiples of 10000 (15000 would be an invalid trade size).

=cut
sub getBaseUnit {
    my $self = shift;
    $self->logger->logcroak("getBaseUnit must be overriden");
}

=method C<balance()>

Returns the current balance in the account ( before p/l of open positions )

=cut
sub balance {
    my $self = shift;

    my $balance = inner() + $self->getExternalDeposits();
    return $balance;
}

=method C<getExternalDeposits()>

Returns the total amount of deposits available as collateral.
This is added to the account balance/nav.

=cut
sub getExternalDeposits {
    return 0;
}

=method C<getBaseCurrency()>

This method must be overriden. Returns the currency in which funds are held in this account. Useful to calculate profit/loss.

=cut
sub getBaseCurrency {
    my $self = shift;
    $self->logger->logcroak("getBaseCurrency must be overriden");
}

=method C<getServerEpoch()>

This method must be overriden. Returns the current unix epoch time on the account server.

=cut
sub getServerEpoch {
    my $self = shift;
    $self->logger->logcroak("getServerEpoch must be overriden");
}

=method C<getServerDateTime()>

This method must be overriden. Returns the current date/time on the account server in '%Y-%m-%d %H:%M:%S' format.

=cut
sub getServerDateTime {
    my $self = shift;
    $self->logger->logcroak("getServerDateTime must be overriden");
}

=method C<checkSignal($symbol, $signal, $args)>

Returns true if the given $signal/$args occurs in $symbol

=cut
sub checkSignal {
    my ($self, $symbol, $signal_definition, $signal_args) = @_;

    $self->logger->info("checkSignal $symbol $signal_definition $signal_args");

    return $self->_signal_processor->checkSignal(
        {
            'expr' => $signal_definition, 
            'symbol' => $symbol,
            'tf' => $signal_args->{timeframe},
            'maxLoadedItems' => $signal_args->{maxLoadedItems},
            'period' => $signal_args->{period},
            'debug' => $signal_args->{debug},
        }
    );
}

=method C<getIndicatorValue($symbol, $indicator, $args)>

Returns the indicator value of $indicator/$args on $symbol.

=cut
sub getIndicatorValue {
    my ($self, $symbol, $indicator, $args) = @_;

    $self->logger->info("getIndicatorValue $symbol $indicator $args");

    my $value = $self->_signal_processor->getIndicatorData( {
                symbol  => $symbol,
                tf      => $args->{timeframe},
                fields  => 'datetime, ' . $indicator,
                maxLoadedItems => $args->{maxLoadedItems},
                numItems => 1,
                debug => $args->{debug},
    } );

    return $value->[0]->[1];
}

=method C<waitForNextTrade($system)>

=cut
sub waitForNextTrade {
    my ($self, $system) = @_;

    $self->logger->logcroak("waitForNextTrade must be overriden");
}

=method C<convertToBaseCurrency($amount, $currentCurrency, $bidask>

Converts $amount from $currentCurrency to the account's base currency, using either 'bid' or 'ask' price.

=cut
sub convertToBaseCurrency {
    my ($self, $amount, $currentCurrency, $bidask) = @_;
    $bidask = 'ask' if (!$bidask);
    if ($bidask ne 'ask' && $bidask ne 'bid') {
        $self->logger->logdie("Invalid value in bidask argument: '$bidask'");
    }

    my $baseCurrency = $self->getBaseCurrency();
    return $amount if ($baseCurrency eq $currentCurrency);

    my $pair;
    if ($self->isSymbolAvailable("$baseCurrency$currentCurrency")) {
        $pair = "$baseCurrency$currentCurrency";
        if ($bidask eq 'ask') {
            $amount /= $self->getAsk($pair);
        } else {
            $amount /= $self->getBid($pair);
        }
    } elsif ($self->isSymbolAvailable("$currentCurrency$baseCurrency")) {
        $pair = "$currentCurrency$baseCurrency";
        if ($bidask eq 'ask') {
            $amount *= $self->getAsk($pair);
        } else {
            $amount *= $self->getBid($pair);
        }
    } else {
        $self->logger->logcroak("Don't know how to convert $currentCurrency to $baseCurrency");
    }

    return sprintf("%.4f", $amount);
}

=method C<convertBaseUnit($symbol, $amount)>

Convert $amount to a multiple of the base unit supported by $symbol.

Eg: If this account provider only supports trading EURUSD in multiples of 10000, and amount is 25000, this functions returns 20000.

See the L</getBaseUnit($symbol)> method.

=cut
sub convertBaseUnit {
    my ($self, $symbol, $amount) = @_;

    $self->logger->info("convertBaseUnit $symbol $amount");

    my $baseUnit = $self->getBaseUnit($symbol);

    return int($amount / $baseUnit) * $baseUnit;
}

=method C<getPosition($symbol)>

Returns a L<Finance::HostedTrader::Position> object for $symbol.

This object will contain information about all open trades in $symbol.

=cut
sub getPosition {
    my ($self, $symbol, $forceRefresh) = @_;

    $self->logger->trace("getPosition $symbol" . ($forceRefresh ? ' with force refresh' : ''));

    my $positions = $self->getPositions($forceRefresh);
    return Finance::HostedTrader::Position->new(symbol=>$symbol) if (!defined($positions->{$symbol}));
    return $positions->{$symbol};
}

=method C<getPositions()>

Returns a hashref whose key is a "trading symbol" and value a L<Finance::HostedTrader::Position> object for that symbol.

=cut
sub getPositions {
    my ($self, $forceRefresh) = @_;

    $self->logger->trace("Positions last refreshed: " . $self->{_lastRefreshPositions});

    # Clients call getPositions() all the time to get list of current positions
    # Avoid going to the server every single time. This improves performance (less network traffic)
    # at a cost of the positions not being necessarly up to date (eg: a position might have been opened/closed via manual trading)
    # Also, this is necessary because some APIs limit the number of requests one can make. Eg: ForexConnect only allow this request
    # 50 time per hour.
    if ($forceRefresh || time() - $self->{_lastRefreshPositions} > 150) {
        $self->logger->trace("fresh getPositions" . ($forceRefresh ? ' with force refresh' : ''));
        $self->refreshPositions();
        $self->{_lastRefreshPositions} = time();
    }
    return $self->{_positions};
}

=method C<closeTrades($symbol,$direction)>

Closes all trades in the given $symbol/$direction at market.

=cut
sub closeTrades {
    my ($self, $symbol, $directionToClose) = @_;

    $self->logger->info("closeTrades $symbol $directionToClose");

    my $posSize = 0;
    my $position = $self->getPosition($symbol,1);
    foreach my $trade (@{ $position->getOpenTradeList }) {
        my $trade_direction = $trade->direction;
        next if ($trade_direction ne $directionToClose);
        $self->closeMarket($trade->id, abs($trade->size));
        $posSize += $trade->size;
    }
    $self->{_lastRefreshPositions} = 0; # Force retrieving fresh position list from server on next call to getPositions

    my $notifier = $self->notifier;
    if ($notifier) {
        my $value = ($directionToClose eq 'long' ? $self->getAsk($symbol) : $self->getBid($symbol) );
        $notifier->close(
            symbol      => $symbol,
            direction   => $directionToClose,
            amount      => $posSize, 
            currentValue=> $value,
            now         => $self->getServerDateTime(),
            nav         => $self->getNav(),
            balance     => $self->balance(),
        );
    }
}

=method C<pl()>

Profit/Loss for currently open positions

=cut
sub pl {
    my $self = shift;
    my $pl = 0;

    $self->logger->trace("pl");

    my $positions = $self->getPositions();
    foreach my $symbol (keys %{$positions}) {
        my $position = $positions->{$symbol};
        $pl += $position->pl;
    }

    return $pl;
}

=method C<getNav()>

Returns current Net Asset Value ( including p/l of open positions )

=cut
sub getNav {
    my $self = shift;

    $self->logger->trace("getNav");

    return $self->balance() + $self->pl();
}

my %symbolBaseMap = (
    AUDCAD => 'CAD',
    AUDCHF => 'CHF',
    AUDJPY => 'JPY',
    AUDNZD => 'NZD',
    AUDUSD => 'USD',
    AUS200 => 'AUD',
    CADCHF => 'CHF',
    CADJPY => 'JPY',
    CHFJPY => 'JPY',
    CHFNOK => 'NOK',
    CHFSEK => 'SEK',
    EURAUD => 'AUD',
    EURCAD => 'CAD',
    EURCHF => 'CHF',
    EURDKK => 'DKK',
    EURGBP => 'GBP',
    EURJPY => 'JPY',
    EURNOK => 'NOK',
    EURNZD => 'NZD',
    EURSEK => 'SEK',
    EURTRY => 'TRY',
    EURUSD => 'USD',
    GBPAUD => 'AUD',
    GBPCAD => 'CAD',
    GBPCHF => 'CHF',
    GBPJPY => 'JPY',
    GBPNZD => 'NZD',
    GBPSEK => 'SEK',
    GBPUSD => 'USD',
    HKDJPY => 'JPY',
    NOKJPY => 'JPY',
    NZDCAD => 'CAD',
    NZDCHF => 'CHF',
    NZDJPY => 'JPY',
    NZDUSD => 'USD',
    SEKJPY => 'JPY',
    SGDJPY => 'JPY',
    TRYJPY => 'JPY',
    USDCAD => 'CAD',
    USDCHF => 'CHF',
    USDDKK => 'DKK',
    USDHKD => 'HKD',
    USDJPY => 'JPY',
    USDMXN => 'MXN',
    USDNOK => 'NOK',
    USDSEK => 'SEK',
    USDSGD => 'SGD',
    USDTRY => 'TRY',
    USDZAR => 'ZAR',
    XAGUSD => 'USD',
    XAUUSD => 'USD',
    ZARJPY => 'JPY',
    ESP35  => 'EUR',
    FRA40  => 'EUR',
    GER30  => 'EUR',
    HKG33  => 'HKD',
    ITA40  => 'EUR',
    JPN225 => 'JPY',
    NAS100 => 'USD',
    SPX500 => 'USD',
    SUI30  => 'CHF',
    SWE30  => 'SEK',
    UK100  => 'GBP',
    UKOil  => 'GBP',
    US30   => 'USD',
    USOil  => 'USD',
    Copper => 'USD',
    XPTUSD => 'USD',
    XPDUSD => 'USD',
    USDOLLAR => 'USD',
    NGAS => 'USD',
    EUSTX50 => 'EUR',
    Bund => 'EUR',
);

=method C<getSymbolBase($symbol)>

Returns the base currency for a symbol, useful for calculating profit/loss.

Eg:
 US Stocks => 'USD'
 EURUSD => 'USD'
 USDCHF => 'CHF'

=cut
sub getSymbolBase {
    my ($self, $symbol) = @_;
    $self->logger->trace("getSymbolBase $symbol");

    if (!exists($symbolBaseMap{$symbol})) {
        $self->logger->logcroak("Unsupported symbol '$symbol'");
    }

    return $symbolBaseMap{$symbol};
}

=method C<isSymbolAvailable($symbol)>
Boolean indicating wether $symbol is available with this account provider
=cut
sub isSymbolAvailable {
    my ($self, $symbol) = @_;

    $self->logger->logdie("Must be overriden");
}

__PACKAGE__->meta->make_immutable;
1;

=head1 SEE ALSO

L<Finance::HostedTrader::Factory::Account>
L<Finance::HostedTrader::Position>

=cut
