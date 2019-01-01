package Finance::HostedTrader::Config::Provider::Factory;

# ABSTRACT: Finance::HostedTrader::Config::Provider::Factory - Dyamically create different types of Finance::HostedTrader::Config::Provider objects

=head1 SYNOPSIS

=cut

use Moo;

sub create_instance {
    my $self = shift;
    my $subclass = shift;
    my $args = shift;

    if ($subclass eq 'fxcm') {
        require Finance::HostedTrader::Config::Provider::FXCM;
        return Finance::HostedTrader::Config::Provider::FXCM->new(%$args);
    } elsif ($subclass eq 'oanda') {
        require Finance::HostedTrader::Config::Provider::Oanda;
        return Finance::HostedTrader::Config::Provider::Oanda->new(%$args);
    } else {
        die("Unknown Trading provider found in config file: $subclass\n");
    }
};

1;

=head1 SEE ALSO


=cut
