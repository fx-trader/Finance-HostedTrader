package Finance::HostedTrader::Factory::Account;

# ABSTRACT: Finance::HostedTrader::Factory::Account - Interface to the Factory broker

=head1 SYNOPSIS

    use Finance::HostedTrader::Factory::Account;

    my $account = Finance::HostedTrader::Factory::Account->new(
                        SUBCLASS    => 'FXCM',
                        address     => $address,
                        port        => $port
                  )->create_instance();

    my $test = Finance::HostedTrader::Factory::Account->new(
                        SUBCLASS    => 'UnitTest',
                        startDate   => '2000-01-01 00:00:00',
                        endDate     => '2020-01-01 00:00:00',
                  )->create_instance();
=cut

use Moose;

use Moose::Util::TypeConstraints;

=attr C<SUBCLASS>

Readonly. Required.

The type of account to instantiate.

Supported values are:
    - ForexConnect
    - UnitTest

=cut
has [qw(SUBCLASS)] => ( is => 'ro', required => 1);

=method C<BUILD>

The constructor takes all arguments passed onto Factory::Account
and passes them to the target class defined by SUBCLASS.

=cut
sub BUILD {
    my $self = shift;
    my $args = shift;

    delete $args->{SUBCLASS};
    $self->{_args} = $args;
}

=method C<create_instance()>

Return an account instance of type SUBCLASS

=cut

sub create_instance {
my $self = shift;

    my $sc = $self->SUBCLASS();

    if ($sc eq 'ForexConnect') {
        require Finance::HostedTrader::Account::FXCM::ForexConnect;
        return Finance::HostedTrader::Account::FXCM::ForexConnect->new( $self->{_args} );
    } elsif ($sc eq 'UnitTest') {
        require Finance::HostedTrader::Account::UnitTest;
        return Finance::HostedTrader::Account::UnitTest->new( $self->{_args} );
    } else {
        die("Don't know about Account class: $sc");
    }
}


__PACKAGE__->meta->make_immutable;

1;

=head1 SEE ALSO

L<Finance::HostedTrader::Account>,
L<Finance::HostedTrader::Account::FXCM::ForexConnect>
L<Finance::HostedTrader::Account::UnitTest>

=cut
