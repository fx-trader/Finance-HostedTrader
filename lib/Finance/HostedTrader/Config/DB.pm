package Finance::HostedTrader::Config::DB;
# ABSTRACT: Finance::HostedTrader::Config::DB - DB Configuration for the Finance::HostedTrader platform

=head1 SYNOPSIS

    use Finance::HostedTrader::Config::DB;
    my $obj = Finance::HostedTrader::Config::DB->new(
                    'dbhost'   => server_name,
                    'dbname'   => dbname,
                    'dbuser'   => dbuser,
                    'dbpasswd' => dbpasswd
                );

=cut

use Moo;

=attr C<dbhost>

MySQL database server to connect to

=cut
has dbhost => (
    is     => 'ro',
    required=>1,
);


=attr C<dbname>

database name where data is stored

=cut
has dbname => (
    is     => 'ro',
    required=>1,
);


=attr C<dbuser>

database user name used to connect

=cut
has dbuser => (
    is     => 'ro',
    required=>1,
);


=attr C<dbpasswd>

database password used to connect

=cut
has dbpasswd => (
    is     => 'ro',
    required=>0,
);

__PACKAGE__->meta->make_immutable;
1;



=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
