package Finance::HostedTrader::Config::Symbols;

# ABSTRACT: Finance::HostedTrader::Config::Symbols - DB Configuration for the Finance::HostedTrader platform

=head1 SYNOPSIS

    use Finance::HostedTrader::Config::Symbols;
    my $obj = Finance::HostedTrader::Config::Symbols->new(
                    'natural'   => ['AUDUSD', 'USDJPY'],
                    'synthetic' => ['AUDJPY'],
                );
=cut

use Moose;
with 'MooseX::Log::Log4perl';

#TODO, should these be in the configuration file (/etc/fxtrader/fx.yml) instead ?
my %symbolBaseMap = (
 AUDCAD => { numerator => 'AUD',        denominator => 'CAD' },
 AUDCHF => { numerator => 'AUD',        denominator => 'CHF' },
 AUDJPY => { numerator => 'AUD',        denominator => 'JPY' },
 AUDNZD => { numerator => 'AUD',        denominator => 'NZD' },
 AUDUSD => { numerator => 'AUD',        denominator => 'USD' },
 AUS200 => { numerator => 'AUS200',     denominator => 'AUD' },
 CADCHF => { numerator => 'CAD',        denominator => 'CHF' },
 CADJPY => { numerator => 'CAD',        denominator => 'JPY' },
 CHFEUR => { numerator => 'CHF',        denominator => 'EUR' },
 CHFJPY => { numerator => 'CHF',        denominator => 'JPY' },
 CHFNOK => { numerator => 'CHF',        denominator => 'NOK' },
 CHFSEK => { numerator => 'CHF',        denominator => 'SEK' },
 EURAUD => { numerator => 'EUR',        denominator => 'AUD' },
 EURCAD => { numerator => 'EUR',        denominator => 'CAD' },
 EURCHF => { numerator => 'EUR',        denominator => 'CHF' },
 EURDKK => { numerator => 'EUR',        denominator => 'DKK' },
 EURGBP => { numerator => 'EUR',        denominator => 'GBP' },
 EURJPY => { numerator => 'EUR',        denominator => 'JPY' },
 EURNOK => { numerator => 'EUR',        denominator => 'NOK' },
 EURNZD => { numerator => 'EUR',        denominator => 'NZD' },
 EURSEK => { numerator => 'EUR',        denominator => 'SEK' },
 EURTRY => { numerator => 'EUR',        denominator => 'TRY' },
 EURUSD => { numerator => 'EUR',        denominator => 'USD' },
 GBPAUD => { numerator => 'GBP',        denominator => 'AUD' },
 GBPCAD => { numerator => 'GBP',        denominator => 'CAD' },
 GBPCHF => { numerator => 'GBP',        denominator => 'CHF' },
 GBPEUR => { numerator => 'GBP',        denominator => 'EUR' },
 GBPJPY => { numerator => 'GBP',        denominator => 'JPY' },
 GBPNZD => { numerator => 'GBP',        denominator => 'NZD' },
 GBPHKD => { numerator => 'GBP',        denominator => 'HKD' },
 GBPSEK => { numerator => 'GBP',        denominator => 'SEK' },
 GBPUSD => { numerator => 'GBP',        denominator => 'USD' },
 JPYEUR => { numerator => 'JPY',        denominator => 'EUR' },
 HKDJPY => { numerator => 'HKD',        denominator => 'JPY' },
 NOKJPY => { numerator => 'NOK',        denominator => 'JPY' },
 NZDCAD => { numerator => 'NZD',        denominator => 'CAD' },
 NZDCHF => { numerator => 'NZD',        denominator => 'CHF' },
 NZDJPY => { numerator => 'NZD',        denominator => 'JPY' },
 NZDUSD => { numerator => 'NZD',        denominator => 'USD' },
 SEKJPY => { numerator => 'SEK',        denominator => 'JPY' },
 SGDJPY => { numerator => 'SGD',        denominator => 'JPY' },
 TRYJPY => { numerator => 'TRY',        denominator => 'JPY' },
 USDCAD => { numerator => 'USD',        denominator => 'CAD' },
 USDCHF => { numerator => 'USD',        denominator => 'CHF' },
 USDDKK => { numerator => 'USD',        denominator => 'DKK' },
 USDHKD => { numerator => 'USD',        denominator => 'HKD' },
 USDJPY => { numerator => 'USD',        denominator => 'JPY' },
 USDMXN => { numerator => 'USD',        denominator => 'MXN' },
 USDNOK => { numerator => 'USD',        denominator => 'NOK' },
 USDSEK => { numerator => 'USD',        denominator => 'SEK' },
 USDSGD => { numerator => 'USD',        denominator => 'SGD' },
 USDTRY => { numerator => 'USD',        denominator => 'TRY' },
 USDZAR => { numerator => 'USD',        denominator => 'ZAR' },
 XAGUSD => { numerator => 'XAG',        denominator => 'USD' },
 XAUUSD => { numerator => 'XAU',        denominator => 'USD' },
 ZARJPY => { numerator => 'ZAR',        denominator => 'JPY' },
 ESP35  => { numerator => 'ESP35',      denominator => 'EUR' },
 FRA40  => { numerator => 'FRA40',      denominator => 'EUR' },
 GER30  => { numerator => 'GER30',      denominator => 'EUR' },
 GER30USD  => { numerator => 'GER30',   denominator => 'USD' },
 HKG33  => { numerator => 'HKG33',      denominator => 'HKD' },
 ITA40  => { numerator => 'ITA40',      denominator => 'EUR' },
 JPN225 => { numerator => 'JPN225',     denominator => 'JPY' },
 NAS100 => { numerator => 'NAS100',     denominator => 'USD' },
 SPX500 => { numerator => 'SPX500',     denominator => 'USD' },
 SUI30  => { numerator => 'SUI30',      denominator => 'CHF' },
 SWE30  => { numerator => 'SWE30',      denominator => 'SEK' },
 UK100  => { numerator => 'UK100',      denominator => 'GBP' },
 UKOil  => { numerator => 'UKOil',      denominator => 'GBP' },
 US30   => { numerator => 'US30',       denominator => 'USD' },
 USOil  => { numerator => 'USOil',      denominator => 'USD' },
 Copper => { numerator => 'Copper',     denominator => 'USD' },
 XPTUSD => { numerator => 'XPT',        denominator => 'USD' },
 XPDUSD => { numerator => 'XPD',        denominator => 'USD' },
 USDOLLAR => { numerator => 'USDOLLAR', denominator => 'USD' },
 NGAS   => { numerator => 'NGAS',       denominator => 'USD' },
 EUSTX50=> { numerator => 'EUSTX50',    denominator => 'EUR' },
 Bund   => { numerator => 'Bund',       denominator => 'EUR' },
 BundUSD=> { numerator => 'Bund',       denominator => 'USD' },
 FRA40USD=> { numerator => 'FRA40',     denominator => 'USD' },
 AUS200USD=> { numerator => 'AUS200',   denominator => 'USD' },
 ESP35USD=> { numerator => 'ESP35',     denominator => 'USD' },
 ITA40USD=> { numerator => 'ITA40',     denominator => 'USD' },
 UK100USD=> { numerator => 'UK100',     denominator => 'USD' },
 UKOilUSD=> { numerator => 'UKOil',     denominator => 'USD' },
 EUSTX50USD=> { numerator => 'EUSTX50', denominator => 'USD' },
 HKG33USD=> { numerator => 'HKG33',     denominator => 'USD' },
 JPN225USD=> { numerator => 'JPN225',   denominator => 'USD' },
 SUI30USD=> { numerator => 'SUI30',     denominator => 'USD' },
);


=attr C<natural>

Returns a list of natural symbols.
Natural symbols originate from the datasource, as opposed to synthetic symbols which are calculated based on natural symbols

Eg: AUDJPY can be synthetically calculated based on AUDUSD and USDJPY

=cut

has natural => (
    is     => 'ro',
    isa    => 'ArrayRef[Str]',
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
    isa    => 'Maybe[HashRef]',
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
