package Finance::HostedTrader::Datasource;
# ABSTRACT: Finance::HostedTrader::Datasource - Database access for the HostedTrader platform

=head1 SYNOPSIS

    use Finance::HostedTrader::Datasource;
    my $db = Datasource->new();

=cut

use DBI;
use Finance::HostedTrader::Config;
use Moo;
use Params::Validate qw(:all);

#TODO, add log4perl to this module and output sql queries in debug mode (not critical, can do the same thing with DBI_TRACE=1)

=attr C<dbh>

Optional DBI handle to the MySQL datasource.

If not present, a new DBI handle is created from the settings in the config file.
=cut
has dbh => (
    is       => 'ro',
    isa      => sub { die("invalid type") unless ($_[0]->isa("DBI::db")) },
    builder  => '_build_dbh',
    lazy     => 1,
    required => 1,
);

sub _build_dbh {
    my $self = shift;
    my $cfg = $self->cfg;
    my $dbh = DBI->connect(
        'DBI:mysql:' . $cfg->db->dbname . ';host=' . $cfg->db->dbhost,
        $cfg->db->dbuser,
        $cfg->db->dbpasswd,
    );

    return $dbh;
}


=attr C<cfg>

Returns the L<Finance::HostedTrader::Config> object associated with this datasource.

=cut
has cfg => (
    is       => 'ro',
    isa      => sub { die("invalid type") unless ($_[0]->isa("Finance::HostedTrader::Config")) },
    builder  => '_build_cfg',
    required => 1,
);

sub _build_cfg {
    return Finance::HostedTrader::Config->new();
}

=method C<getLastClose>


Returns an array consisting of two elements, the last known close price of an instrument, and the datetime of that close price

my ($datetime, $close) = $self->getLastClose('EURUSD')

=cut

sub getLastClose {
    my $self = shift;
    my %args = validate( @_, {
        instrument  => 1,
        provider    => 0,
    });

    my $instrument      = $args{instrument};
    my $data_provider   = $self->cfg->provider($args{provider});

    my $cfg = $self->cfg;
    my $timeframe = 300;#TODO hardcoded lowest available timeframe is 5minute. Could look it up in $cfg instead.

    my $tableName = $data_provider->getTableName($instrument, $timeframe);
    my $sql = qq{
            SELECT T1.datetime,
            ROUND(T1.mid_close,4) AS close
            FROM $tableName AS T1
            ORDER BY T1.datetime DESC
            LIMIT 1
        };

    return $self->dbh->selectrow_array($sql);

}

1;

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
