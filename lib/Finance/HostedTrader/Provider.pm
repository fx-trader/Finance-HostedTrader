package Finance::HostedTrader::Provider;

# ABSTRACT: Finance::HostedTrader::Provider - Base class for trading and historical data providers

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

=attr C<synthetic>

Returns a list of synthetic instruments.

Synthetic instruments can be calculated based on existing instruments supported by the underlying provider.

=cut


sub _around_synthetic_instruments {
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
around 'synthetic' => \&_around_synthetic_instruments;


sub synthetic_names {
    my $self = shift;

    my $synthetics = $self->synthetic;
    return keys %$synthetics;
}



has 'id' => (
    is => 'ro',
);

#sub _build_cfg {
#    return Finance::HostedTrader::Config->new();
#}

sub getInstruments {
    my ($self) = @_;

    return sort keys %{ $self->instrumentMap() };
}

sub getAllInstruments {
    my ($self) = @_;

    return $self->getInstruments(), $self->synthetic_names;
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
    my ($class, $type, $args) = @_;

    $type = lc($type);
    if ($type eq 'oanda') {
#    print Dumper($args);exit;use Data::Dumper;
        require Finance::HostedTrader::Provider::Oanda;
        return Finance::HostedTrader::Provider::Oanda->new( id => $type, %$args );
    } elsif ($type eq 'fxcm') {
        require Finance::HostedTrader::Provider::FXCM;
        return Finance::HostedTrader::Provider::FXCM->new( id => $type, %$args );
    } else {
        use Carp;
        confess("Unsupported data provider '$type'");
    }
}

1;
