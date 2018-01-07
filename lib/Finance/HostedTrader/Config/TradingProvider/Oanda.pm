package Finance::HostedTrader::Config::TradingProvider::Oanda;

# ABSTRACT: Finance::HostedTrader::Config::TradingProvider::Oanda - Configuration for the Oanda trading platform

=head1 SYNOPSIS

=cut

use Moo;

extends 'Finance::HostedTrader::Config::TradingProvider';


=attr C<accountid>

Account to connect to

=cut

has accountid => (
    is     => 'ro',
    required=>1,
);

=attr C<token>

Access token to connect to

=cut


has token => (
    is     => 'ro',
    required=>1,
);

=attr C<serverURL>

Oanda server URL. https://api-fxpractice.oanda.com for demo or https://api-fxtrade.oanda.com for real.

See http://developer.oanda.com/rest-live-v20/development-guide/

=cut


has serverURL => (
    is     => 'ro',
    default=> 'https://api-fxtrade.oanda.com',
    required=>1,
);

1;

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
