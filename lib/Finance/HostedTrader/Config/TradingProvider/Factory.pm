package Finance::HostedTrader::Config::TradingProvider::Factory;

# ABSTRACT: Finance::HostedTrader::Config::TradingProvider::Factory - Dyamically create different types of Finance::HostedTrader::Config::TradingProvider objects

=head1 SYNOPSIS

=cut

use Moose;

sub create_instance {
    my $self = shift;
    my $subclass = shift;
    my $args = shift;

    if ($subclass eq 'fxcm') {
        require Finance::HostedTrader::Config::TradingProvider::FXCM;
        return Finance::HostedTrader::Config::TradingProvider::FXCM->new(%$args);
    } else {
        die("Unknown Trading provider found in config file: $subclass\n");
    }
};

__PACKAGE__->meta->make_immutable;

1;

=head1 SEE ALSO


=cut
