package Finance::HostedTrader::Trade;
# ABSTRACT: Finance::HostedTrader::Config::Trade - Trade object

=head1 SYNOPSIS

    use Finance::HostedTrader::Trade;
    my $obj = Finance::HostedTrader::Trade->new(
                );
=cut

use Moose;
with 'MooseX::Log::Log4perl';
use Moose::Util::TypeConstraints;
use Math::Round qw(nearest);

subtype 'positiveNum'
    => as 'Num'
    => where { $_ > 0 }
    => message { "The number provided ($_) must be positive" };


=attr C<id>


=cut
has id => (
    is     => 'ro',
    isa    => 'Str',
    required=>1,
);

=attr C<symbol>


=cut
has symbol => (
    is     => 'ro',
    isa    => 'Str',
    required=>1,
);

=attr C<direction>

long or short

=cut
enum 'tradeDirection' => qw(long short);
has direction => (
    is     => 'ro',
    isa    => 'Str',
    required=>1,
);


=attr C<openDate>


=cut
has openDate => (
    is     => 'ro',
    isa    => 'Str',
    required=>1,
);


=attr C<openPrice>


=cut
has openPrice => (
    is     => 'ro',
    isa    => 'positiveNum',
    required=>1,
);

=attr C<size>


=cut
has size => (
    is     => 'rw',#TODO once initialized, trade size can only decrease for longs and increase for shorts. enforce this in the Trade object
    isa    => 'Int',
    required=>1,
);


=attr C<closeDate>


=cut
has closeDate => (
    is     => 'ro',
    isa    => 'Str',
    required=>0,
);

=attr C<closePrice>


=cut
has closePrice => (
    is     => 'ro',
    isa    => 'Num',
    required=>0,
);

=attr C<pl>


=cut
has pl => (
    is     => 'rw',
    isa    => 'Num',
    required=>0,
);

=method BUILD

Constructor. Validates that short positions have negative sizes, and long positions have positive sizes.

=cut
sub BUILD {
    my $self = shift;
    my $self_direction = $self->direction;
    my $self_size = $self->size;

    if ($self_direction eq 'short') {
        die('Shorts need to be negative numbers') if ($self_size >= 0);
    } else {
        die('Longs need to be positive numbers') if ($self_size <= 0);
    }
} 

#=method C<profit>
#
#
#=cut
# this method is not really used, so commenting out for now
#sub profit {
#    my ($self) = @_;
#
#    return undef if (!defined($self->closePrice));
#    return sprintf("%.4f", $self->closePrice - $self->openPrice) if ($self->direction eq 'long');
#    return sprintf("%.4f", $self->openPrice - $self->closePrice) if ($self->direction eq 'short');
#    die('WTF');
#}

=method C<amountAtRisk>
=cut
sub amountAtRisk {
    my $self = shift;
    my $account = shift;
    my $system = shift;
    my $symbol = $self->symbol;

    my $size = $self->size();
    my $direction = $self->direction;
    my $stopLoss = $system->_getSignalValue('exit', $symbol, $direction);
    $self->logger->logconfess("Could not get stop loss for $symbol $direction") if (!defined($stopLoss));

    my $value = ($direction eq 'long' ? $account->getAsk($symbol) : $account->getBid($symbol));
    my $maxLossPts = $value - $stopLoss;
    my $pl = nearest(.0001, $maxLossPts * $size);
    my $symbolBaseUnit = $account->getSymbolBase($symbol);

    return nearest(.0001, $account->convertToBaseCurrency($pl, $symbolBaseUnit, 'bid'));
}

__PACKAGE__->meta->make_immutable;
1;



=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
