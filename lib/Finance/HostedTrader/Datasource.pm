package Finance::HostedTrader::Datasource;
# ABSTRACT: Finance::HostedTrader::Datasource - Database access for the HostedTrader platform

=head1 SYNOPSIS

    use Finance::HostedTrader::Datasource;
    my $db = Datasource->new();

=cut

use DBI;
use Finance::HostedTrader::Config;
use Data::Dumper;
use Moose;
use Params::Validate qw(:all);

#TODO, add log4perl to this module and output sql queries in debug mode (not critical, can do the same thing with DBI_TRACE=1)

=attr C<dbh>

Optional DBI handle to the MySQL datasource.

If not present, a new DBI handle is created from the settings in the config file.
=cut
has dbh => (
    is       => 'ro',
    isa      => 'DBI::db',
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
        { RaiseError => 1}
    );


    # Derived merge optimization is explained here: https://mariadb.com/kb/en/mariadb/derived-table-merge-optimization/
    # Using this optimization breaks the use of the UDF somehow the UDF ends up running after query values have been
    # filtered, so it stops you evaluating UDF values in the WHERE clause.
    # TODO: raise a bug with mariadb about this.
    $dbh->do('set @@optimizer_switch=\'derived_merge=OFF\'');
    # More documentation about subquery optimization available at https://mariadb.com/kb/en/mariadb/subquery-optimizations/

    return $dbh;
}


=attr C<cfg>

Returns the L<Finance::HostedTrader::Config> object associated with this datasource.

This object contains a list of available timeframes and symbols in this data source.
=cut
has cfg => (
    is       => 'ro',
    isa      => 'Finance::HostedTrader::Config',
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
        symbol  => 1,
    });

    my $symbol = $args{symbol};

    my $cfg = $self->cfg;
    my $timeframe = 300;#TODO hardcoded lowest available timeframe is 5min. Could look it up in $cfg instead.

    my $sql = qq{
            SELECT T1.datetime,
            ROUND(T1.close,4) AS close
            FROM $symbol\_$timeframe AS T1
            ORDER BY T1.datetime DESC
            LIMIT 1
        };

    return $self->dbh->selectrow_array($sql);

}

1;

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
