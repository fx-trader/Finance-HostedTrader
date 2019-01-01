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

sub _build_cfg {
    return Finance::HostedTrader::Config->new();
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

sub factory {
    my $class = shift;
    my $type = shift;

    if ($type eq 'Oanda') {
        require Finance::HostedTrader::Provider::Oanda;
        return Finance::HostedTrader::Provider::Oanda->new();
    } elsif ($type eq 'FXCM') {
        require Finance::HostedTrader::Provider::FXCM;
        return Finance::HostedTrader::Provider::FXCM->new();
    } else {
        die("Unsupported data provider '$type'");
    }
}

1;
