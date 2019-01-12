package Finance::HostedTrader::Provider;

# ABSTRACT: Finance::HostedTrader::Config::Provider - Base class for historical data providers

=head1 SYNOPSIS

=cut

use Moo;
with 'MooseX::Log::Log4perl';

use Finance::HostedTrader::Config;

has instrumentMap => (
    is          => 'ro',
    required    => 1,
    builder     => '_build_instrumentMap',
);

has timeframeMap => (
    is          => 'ro',
    required    => 1,
    builder     => '_build_timeframeMap',
);

has cfg => (
    is      => 'ro',
    isa      => sub { die("invalid type") unless ($_[0]->isa("Finance::HostedTrader::Config")) },
    required=> 1,
    builder => '_build_cfg',
);

has 'id' => (
    is => 'ro',
);

sub _build_cfg {
    return Finance::HostedTrader::Config->new();
}

sub getInstruments {
    my ($self) = @_;

    return sort keys %{ $self->instrumentMap() };
}

sub getAllInstruments {
    my ($self) = @_;

    return $self->getInstruments(), $self->cfg->symbols->synthetic_names;
}

sub convertInstrumentTo {
    my ($self, $symbol) = @_;

    $self->log->logconfess("Unsupported symbol '$symbol'") if (!exists($self->instrumentMap->{$symbol}));
    return $self->instrumentMap->{$symbol};
}

sub convertTimeframeTo {
    my ($self, $timeframe) = @_;

    $self->log->logconfess("Unsupported timeframe '$timeframe'") if (!exists($self->timeframeMap->{$timeframe}));
    return $self->timeframeMap->{$timeframe};
}

sub getInstrumentNumerator {
    my ($self, $instrument) = @_;

    my ($numerator, $denominator) = split(/_/, $instrument, 2);
    return $numerator;
}

sub getInstrumentDenominator {
    my ($self, $instrument) = @_;

    my ($numerator, $denominator) = split(/_/, $instrument, 2);
    return $denominator;
}

sub getTableName {
    my ($self, $instrument, $timeframe) = @_;

    my $provider_id = $self->id;
    return "${provider_id}_${instrument}_${timeframe}";
}

sub factory {
    my $class = shift;
    my $type = shift;

    $type = lc($type);
    if ($type eq 'oanda') {
        require Finance::HostedTrader::Provider::Oanda;
        return Finance::HostedTrader::Provider::Oanda->new( id => $type );
    } elsif ($type eq 'fxcm') {
        require Finance::HostedTrader::Provider::FXCM;
        return Finance::HostedTrader::Provider::FXCM->new( id => $type );
    } else {
        die("Unsupported data provider '$type'");
    }
}

1;
