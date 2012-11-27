package Finance::HostedTrader::Config::TradingProvider::FXCM;

# ABSTRACT: Finance::HostedTrader::Config::TradingProvider::FXCM - Configuration for the FXCM trading platform

=head1 SYNOPSIS

=cut

use strict;
use warnings;
use Moose;
use Moose::Util::TypeConstraints;

extends 'Finance::HostedTrader::Config::TradingProvider';


=attr C<username>

Username to connect to the trading provider

=cut

has username => (
    is     => 'ro',
    isa    => 'Str',
    required=>1,
);

=attr C<password>

Password to connect to the trading provider

=cut


has password => (
    is     => 'ro',
    isa    => 'Str',
    required=>1,
);

=attr C<accountType>

FXCM account type. Either 'Demo' or 'Real'.

=cut


has accountType => (
    is     => 'ro',
    isa    => 'Str',
    required=>1,
);

=attr C<serverURL>

ForexConnect server URL. Tipically http://www.fxcorporate.com/Hosts.jsp

=cut


has serverURL => (
    is     => 'ro',
    isa    => 'Str',
    default=> 'http://www.fxcorporate.com/Hosts.jsp',
    required=>1,
);


__PACKAGE__->meta->make_immutable;
1;

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
