package Finance::HostedTrader::Config::TradingProvider::FXCM;

# ABSTRACT: Finance::HostedTrader::Config::TradingProvider::FXCM - Configuration for the FXCM trading platform

=head1 SYNOPSIS

=cut

use Moo;

extends 'Finance::HostedTrader::Config::TradingProvider';


=attr C<username>

Username to connect to the trading provider

=cut

has username => (
    is     => 'ro',
    required=>1,
);

=attr C<password>

Password to connect to the trading provider

=cut


has password => (
    is     => 'ro',
    required=>1,
);

=attr C<accountType>

FXCM account type. Either 'Demo' or 'Real'.

=cut


has accountType => (
    is     => 'ro',
    required=>1,
);

=attr C<serverURL>

ForexConnect server URL. Tipically http://www.fxcorporate.com/Hosts.jsp

=cut


has serverURL => (
    is     => 'ro',
    default=> 'http://www.fxcorporate.com/Hosts.jsp',
    required=>1,
);

1;

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
