package Finance::HostedTrader::Config::Symbols;

# ABSTRACT: Finance::HostedTrader::Config::Symbols - DB Configuration for the Finance::HostedTrader platform

=head1 SYNOPSIS

    use Finance::HostedTrader::Config::Symbols;
    my $obj = Finance::HostedTrader::Config::Symbols->new(
                    'natural'   => ['AUDUSD', 'USDJPY'],
                    'synthetic' => ['AUDJPY'],
                );
=cut

use Moo;
with 'MooseX::Log::Log4perl';

#TODO, should these be in the configuration file (/etc/fxtrader/fx.yml) instead ?

# the values in the meta1 and meta2 keys are used to calculate position sizes

my %symbolBaseMap = (
 AUDCAD => { numerator => 'AUD',        denominator => 'CAD', meta1 => 10000, meta2 => 1 },
 AUDCHF => { numerator => 'AUD',        denominator => 'CHF', meta1 => 10000, meta2 => 1 },
 AUDJPY => { numerator => 'AUD',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 AUDNZD => { numerator => 'AUD',        denominator => 'NZD', meta1 => 10000, meta2 => 1 },
 AUDUSD => { numerator => 'AUD',        denominator => 'USD', meta1 => 10000, meta2 => 1 },
 AUS200 => { numerator => 'AUS200',     denominator => 'AUD', meta1 => 1    , meta2 => 1 },
 CADCHF => { numerator => 'CAD',        denominator => 'CHF', meta1 => 10000, meta2 => 1 },
 CADJPY => { numerator => 'CAD',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 CHFEUR => { numerator => 'CHF',        denominator => 'EUR', meta1 => 10000, meta2 => 1 },
 CHFJPY => { numerator => 'CHF',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 CHFNOK => { numerator => 'CHF',        denominator => 'NOK', meta1 => 10000, meta2 => 1 },
 CHFSEK => { numerator => 'CHF',        denominator => 'SEK', meta1 => 10000, meta2 => 1 },
 EURAUD => { numerator => 'EUR',        denominator => 'AUD', meta1 => 10000, meta2 => 1 },
 EURCAD => { numerator => 'EUR',        denominator => 'CAD', meta1 => 10000, meta2 => 1 },
 EURCHF => { numerator => 'EUR',        denominator => 'CHF', meta1 => 10000, meta2 => 1 },
 EURDKK => { numerator => 'EUR',        denominator => 'DKK', meta1 => 10000, meta2 => 1 },
 EURGBP => { numerator => 'EUR',        denominator => 'GBP', meta1 => 10000, meta2 => 1 },
 EURJPY => { numerator => 'EUR',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 EURNOK => { numerator => 'EUR',        denominator => 'NOK', meta1 => 10000, meta2 => 1 },
 EURNZD => { numerator => 'EUR',        denominator => 'NZD', meta1 => 10000, meta2 => 1 },
 EURSEK => { numerator => 'EUR',        denominator => 'SEK', meta1 => 10000, meta2 => 1 },
 EURTRY => { numerator => 'EUR',        denominator => 'TRY', meta1 => 10000, meta2 => 1 },
 EURUSD => { numerator => 'EUR',        denominator => 'USD', meta1 => 10000, meta2 => 1 },
 GBPAUD => { numerator => 'GBP',        denominator => 'AUD', meta1 => 10000, meta2 => 1 },
 GBPCAD => { numerator => 'GBP',        denominator => 'CAD', meta1 => 10000, meta2 => 1 },
 GBPCHF => { numerator => 'GBP',        denominator => 'CHF', meta1 => 10000, meta2 => 1 },
 GBPEUR => { numerator => 'GBP',        denominator => 'EUR', meta1 => 10000, meta2 => 1 },
 GBPJPY => { numerator => 'GBP',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 GBPNZD => { numerator => 'GBP',        denominator => 'NZD', meta1 => 10000, meta2 => 1 },
 GBPHKD => { numerator => 'GBP',        denominator => 'HKD', meta1 => 10000, meta2 => 1 },
 GBPSEK => { numerator => 'GBP',        denominator => 'SEK', meta1 => 10000, meta2 => 1 },
 GBPUSD => { numerator => 'GBP',        denominator => 'USD', meta1 => 10000, meta2 => 1 },
 JPYEUR => { numerator => 'JPY',        denominator => 'EUR', meta1 => 10000, meta2 => 1 },
 HKDJPY => { numerator => 'HKD',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 NOKJPY => { numerator => 'NOK',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 NZDCAD => { numerator => 'NZD',        denominator => 'CAD', meta1 => 10000, meta2 => 1 },
 NZDCHF => { numerator => 'NZD',        denominator => 'CHF', meta1 => 10000, meta2 => 1 },
 NZDJPY => { numerator => 'NZD',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 NZDUSD => { numerator => 'NZD',        denominator => 'USD', meta1 => 10000, meta2 => 1 },
 SEKJPY => { numerator => 'SEK',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 SGDJPY => { numerator => 'SGD',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 TRYJPY => { numerator => 'TRY',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 USDCAD => { numerator => 'USD',        denominator => 'CAD', meta1 => 10000, meta2 => 1 },
 USDCHF => { numerator => 'USD',        denominator => 'CHF', meta1 => 10000, meta2 => 1 },
 USDDKK => { numerator => 'USD',        denominator => 'DKK', meta1 => 10000, meta2 => 1 },
 USDHKD => { numerator => 'USD',        denominator => 'HKD', meta1 => 10000, meta2 => 1 },
 USDEUR => { numerator => 'USD',        denominator => 'EUR', meta1 => 10000, meta2 => 1 },
 USDJPY => { numerator => 'USD',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 USDMXN => { numerator => 'USD',        denominator => 'MXN', meta1 => 10000, meta2 => 1 },
 USDNOK => { numerator => 'USD',        denominator => 'NOK', meta1 => 10000, meta2 => 1 },
 USDSEK => { numerator => 'USD',        denominator => 'SEK', meta1 => 10000, meta2 => 1 },
 USDSGD => { numerator => 'USD',        denominator => 'SGD', meta1 => 10000, meta2 => 1 },
 USDTRY => { numerator => 'USD',        denominator => 'TRY', meta1 => 10000, meta2 => 1 },
 USDZAR => { numerator => 'USD',        denominator => 'ZAR', meta1 => 10000, meta2 => 1 },
 XAGUSD => { numerator => 'XAG',        denominator => 'USD', meta1 => 100  , meta2 => 1 },
 XAGEUR => { numerator => 'XAG',        denominator => 'EUR', meta1 => 100  , meta2 => 1 },
 XAUUSD => { numerator => 'XAU',        denominator => 'USD', meta1 => 10   , meta2 => 1 },
 ZARJPY => { numerator => 'ZAR',        denominator => 'JPY', meta1 => 100  , meta2 => 1 },
 ESP35  => { numerator => 'ESP35',      denominator => 'EUR', meta1 => 1    , meta2 => 1 },
 FRA40  => { numerator => 'FRA40',      denominator => 'EUR', meta1 => 1    , meta2 => 1 },
 GER30  => { numerator => 'GER30',      denominator => 'EUR', meta1 => 1    , meta2 => 1 },
 GER30USD  => { numerator => 'GER30',   denominator => 'USD', meta1 => 1    , meta2 => 1 },
 HKG33  => { numerator => 'HKG33',      denominator => 'HKD', meta1 => 1    , meta2 => 1 },
 ITA40  => { numerator => 'ITA40',      denominator => 'EUR', meta1 => 1    , meta2 => 1 },
 JPN225 => { numerator => 'JPN225',     denominator => 'JPY', meta1 => 1    , meta2 => 1 },
 NAS100 => { numerator => 'NAS100',     denominator => 'USD', meta1 => 1    , meta2 => 1 },
 SPX500 => { numerator => 'SPX500',     denominator => 'USD', meta1 => 1    , meta2 => 1 },
 SUI30  => { numerator => 'SUI30',      denominator => 'CHF', meta1 => 1    , meta2 => 1 },
 SWE30  => { numerator => 'SWE30',      denominator => 'SEK', meta1 => 1    , meta2 => 1 },
 UK100  => { numerator => 'UK100',      denominator => 'GBP', meta1 => 1    , meta2 => 1 },
 UKOil  => { numerator => 'UKOil',      denominator => 'GBP', meta1 => 100  , meta2 => 1 },
 US30   => { numerator => 'US30',       denominator => 'USD', meta1 => 1    , meta2 => 1 },
 USOil  => { numerator => 'USOil',      denominator => 'USD', meta1 => 1    , meta2 => 1 },
 Copper => { numerator => 'Copper',     denominator => 'USD', meta1 => 2000 , meta2 => 1 },
 Corn   => { numerator => 'Corn',       denominator => 'USD', meta1 => 2000 , meta2 => 1 },
 Wheat  => { numerator => 'Corn',       denominator => 'USD', meta1 => 2000 , meta2 => 1 },
 XPTUSD => { numerator => 'XPT',        denominator => 'USD', meta1 => 10   , meta2 => 1 },
 XPDUSD => { numerator => 'XPD',        denominator => 'USD', meta1 => 10   , meta2 => 1 },
 USDOLLAR => { numerator => 'USDOLLAR', denominator => 'USD', meta1 => 10000, meta2 => 1 },
 NGAS   => { numerator => 'NGAS',       denominator => 'USD', meta1 => 1000 , meta2 => 1 },
 EUSTX50=> { numerator => 'EUSTX50',    denominator => 'EUR', meta1 => 10000, meta2 => 1 },
 Bund   => { numerator => 'Bund',       denominator => 'EUR', meta1 => 100  , meta2 => 10 },
 BundUSD=> { numerator => 'Bund',       denominator => 'USD', meta1 => 10000, meta2 => 10 },
 FRA40USD=> { numerator => 'FRA40',     denominator => 'USD', meta1 => 10000, meta2 => 1 },
 AUS200USD=> { numerator => 'AUS200',   denominator => 'USD', meta1 => 10000, meta2 => 1 },
 ESP35USD=> { numerator => 'ESP35',     denominator => 'USD', meta1 => 10000, meta2 => 1 },
 ITA40USD=> { numerator => 'ITA40',     denominator => 'USD', meta1 => 10000, meta2 => 1 },
 UK100USD=> { numerator => 'UK100',     denominator => 'USD', meta1 => 10000, meta2 => 1 },
 UKOilUSD=> { numerator => 'UKOil',     denominator => 'USD', meta1 => 10000, meta2 => 1 },
 EUSTX50USD=> { numerator => 'EUSTX50', denominator => 'USD', meta1 => 10000, meta2 => 1 },
 HKG33USD=> { numerator => 'HKG33',     denominator => 'USD', meta1 => 10000, meta2 => 1 },
 JPN225USD=> { numerator => 'JPN225',   denominator => 'USD', meta1 => 10000, meta2 => 1 },
 SUI30USD=> { numerator => 'SUI30',     denominator => 'USD', meta1 => 10000, meta2 => 1 },
);


=attr C<natural>

Returns a list of natural symbols.
Natural symbols originate from the datasource, as opposed to synthetic symbols which are calculated based on natural symbols

Eg: AUDJPY can be synthetically calculated based on AUDUSD and USDJPY

=cut

has natural => (
    is     => 'ro',
    required=>1,
);

=attr C<synthetic>

Returns a list of synthetic symbols.

See the description for natural symbols.

=cut


sub _around_synthetic_symbols {
    my $orig = shift;
    my $self = shift;

    return $self->$orig(@_) if @_; #Call the Moose generated setter if this is a set call (actually because the attributes are read-only we'll never 

    # If it is a get call, call the Moose generated getter
    my $value = $self->$orig();
    return $value if (defined($value));
    return {};
}

has synthetic => (
    is     => 'ro',
    builder => '_build_synthetic',
    required=>0,
);

sub _build_synthetic {
    return {};
}

#register method modifier so that undef values can be converted to empty lists
around 'synthetic' => \&_around_synthetic_symbols;


sub synthetic_names {
    my $self = shift;

    my $synthetics = $self->synthetic;
    return [ keys %$synthetics ];
}

=method C<all>

Returns a list of all symbols, natural and synthetic.

=cut
sub all {
    my $self = shift;
    return [ @{ $self->natural }, @{ $self->synthetic_names } ];

}

=method C<getSymbolDenominator($symbol)>

Returns the asset the symbol is denominated in.

This is required to calculate PL in a different currency, or
create a synthetic symbol based in a different currency.

Eg:
 GER30      => 'EUR' ( Denominated in EUR )
 NAS100     => 'USD' ( Denominated in USD )
 EURUSD     => 'USD' ( Denominated in USD )
 USDCHF     => 'CHF' ( Denominated in CHF )

=cut
sub getSymbolDenominator {
    my ($self, $symbol) = @_;

    $self->logger->logconfess("Required parameter symbol missing") unless(defined($symbol));
    if (!exists($symbolBaseMap{$symbol})) {
        $self->logger->logconfess("Symbol '$symbol' does not exist in ".__PACKAGE__."::\$symbolBaseMap");
    }

    return $symbolBaseMap{$symbol}->{denominator};
}

=method C<getSymbolNumerator($symbol)>

Returns the asset the symbol represents.

Eg:
 GER30      => 'GER30'  ( Represents in GER30 )
 GER30USD   => 'GER30'  ( Represents in GER30 )
 EURUSD     => 'EUR'    ( Represents EUR )
 USDCHF     => 'USD'    ( Represents USD )

=cut

sub getSymbolNumerator {
    my ($self, $symbol) = @_;

    if (!exists($symbolBaseMap{$symbol})) {
        $self->logger->logcroak("Unsupported symbol '$symbol'");
    }

    return $symbolBaseMap{$symbol}->{numerator};
}

=method C<getMeta1($symbol)>

Returns information about symbol. This information is used to calculate position sizes.
I don't know exactly what the information is, this documentation needs improving.

=cut

sub getSymbolMeta1 {
    my ($self, $symbol) = @_;

    if (!exists($symbolBaseMap{$symbol})) {
        $self->logger->logcroak("Unsupported symbol '$symbol'");
    }

    return $symbolBaseMap{$symbol}->{meta1};
}

=method C<getMeta2($symbol)>

Returns information about symbol. This information is used to calculate position sizes.
I don't know exactly what the information is, this documentation needs improving.

=cut

sub getSymbolMeta2 {
    my ($self, $symbol) = @_;

    if (!exists($symbolBaseMap{$symbol})) {
        $self->logger->logcroak("Unsupported symbol '$symbol'");
    }

    return $symbolBaseMap{$symbol}->{meta2};
}

sub get_symbols_by_denominator {
    my ($self, $base) = @_;

    return [ grep { $self->getSymbolDenominator($_) eq $base } @{$self->all} ];
}

sub get_symbols_by_numerator {
    my ($self, $base) = @_;

    return [ grep { $self->getSymbolNumerator($_) eq $base } @{$self->all} ];
}


__PACKAGE__->meta->make_immutable;
1;

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
