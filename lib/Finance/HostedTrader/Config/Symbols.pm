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
 GER30USD  => 'USD',
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
 NGAS   => 'USD',
 EUSTX50=> 'EUR',
 Bund   => 'EUR',
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

    return $self->$orig(@_) if @_; #Call the Moose generated setter if this is a set call (actually because the attributes are read-only we'll never have a set call, but just in case it changes later)

    # If it is a get call, call the Moose generated getter
    my $value = $self->$orig();
    return $value if (defined($value));
    return [];
}

has synthetic => (
    is     => 'ro',
    isa    => 'Maybe[ArrayRef]',
    builder => '_build_synthetic',
    required=>0,
);
#register method modifier so that undef values can be converted to empty lists
around 'synthetic' => \&_around_synthetic_symbols;

sub _build_synthetic {
    return [];
}

sub synthetic_names {
    my $self = shift;

    my $synthetics = $self->synthetic;
    return [ map { $_->{name} } @$synthetics ];
}

=method C<all>

Returns a list of all symbols, natural and synthetic.

=cut
sub all {
    my $self = shift;
    return [ @{ $self->natural }, @{ $self->synthetic_names } ];

}

=method C<getSymbolBase($symbol)>

Returns the base currency for a symbol.

This is required to calculate PL in a different currency, or
create a synthetic symbol based in a different currency.

Eg:
 GER30      => 'EUR'
 NAS100     => 'USD'
 EURUSD     => 'USD'
 USDCHF     => 'CHF'

=cut
sub getSymbolBase {
    my ($self, $symbol) = @_;

    if (!exists($symbolBaseMap{$symbol})) {
        $self->logger->logcroak("Unsupported symbol '$symbol'");
    }

    return $symbolBaseMap{$symbol};
}


__PACKAGE__->meta->make_immutable;
1;

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
