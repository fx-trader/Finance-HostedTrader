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

=attr C<debug>

Optional If set to a true value, prints SQL queries to stdout.

Defaults to false.
=cut
has debug => (
    is       => 'ro',
    isa      => 'Bool',
    default  => 0,
    required => 0,
);

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

=method C<convertOHLCTimeSeries>

Converts data between timeframes

=cut
sub convertOHLCTimeSeries {
    my $self = shift;
    my %args = validate( @_, {
        symbol      => 1,
        tf_synthetic=> 1,
        start_date  => 1,
        end_date    => 1,
    });

    my ( $symbol, $start_date, $end_date ) = ( $args{symbol}, $args{start_date}, $args{end_date} );
    my $tf_src = $args{tf_synthetic}->{base} or die("Invalid timeframe spec, fix fx.yml");
    my $tf_dst = $args{tf_synthetic}->{name} or die("Invalid timeframe spec, fix fx.yml");
    my ( $where_clause, $start, $end, $limit ) = ( '', '', '', -1 );
    die("Cannot convert to a smaller timeframe: from $tf_src to $tf_dst") if ( $tf_dst < $tf_src );

    my ( $date_select, $date_group );

#TODO - date_select is duplicated with Timeframes.pm
    if ( $tf_dst == 300 ) {
        $date_select =
"CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 5) * 5, ':00') AS DATETIME)";
    }
    elsif ( $tf_dst == 900 ) {
        $date_select =
"CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 15) * 15, ':00') AS DATETIME)";
    }
    elsif ( $tf_dst == 1800 ) {
        $date_select =
"CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 30) * 30, ':00') AS DATETIME)";
    }
    elsif ( $tf_dst == 3600 ) {
        $date_select = "date_format(datetime, '%Y-%m-%d %H:00:00')";
    }
    elsif ( $tf_dst == 7200 ) {
        $date_select =
"CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  floor(hour(datetime) / 2) * 2, ':00:00') AS DATETIME)";
    }
    elsif ( $tf_dst == 10800 ) {
        $date_select =
"CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  floor(hour(datetime) / 3) * 3, ':00:00') AS DATETIME)";
    }
    elsif ( $tf_dst == 14400 ) {
        $date_select =
"CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  floor(hour(datetime) / 4) * 4, ':00:00') AS DATETIME)";
    }
    elsif ( $tf_dst == 86400 ) {
        $date_select = "date_format(datetime, '%Y-%m-%d 00:00:00')";
    }
    elsif ( $tf_dst == 604800 ) {
        $date_select =
"date_format(date_sub(datetime, interval weekday(datetime)+1 DAY), '%Y-%m-%d 00:00:00')";
        $date_group = "date_format(datetime, '%x-%v')";
    }
    else {
        die("timeframe not supported ($tf_dst)");
    }
    $date_group = $date_select unless ( defined($date_group) );

    my $sql = qq|
INSERT INTO $symbol\_$tf_dst(datetime, open, high, low, close)
SELECT $date_select, SUBSTRING_INDEX(GROUP_CONCAT(CAST(open AS CHAR) ORDER BY datetime), ',', 1) as open, MAX(high) as high, MIN(low) as low, SUBSTRING_INDEX(GROUP_CONCAT(CAST(close AS CHAR) ORDER BY datetime DESC), ',', 1) as close
FROM $symbol\_$tf_src
WHERE datetime >= '$start_date' AND datetime < '$end_date'
GROUP BY $date_group
ON DUPLICATE KEY UPDATE open=values(open), low=values(low), high=values(high), close=values(close)
|;

    print "\n----------\n$sql\n----------\n" if ($self->debug);
    $self->dbh->do($sql);
}

=method C<createSynthetic>

Creates data for synthetic pairs, based on existing pairs, and inserts data
in the database for the requested timeframe.



For example, GBPJPY can be derived from GBPUSD AND USDJPY.

=cut
sub createSynthetic {
    my ( $self, $synthetic, $timeframe ) = @_;

    my $synthetic_name  = $synthetic->{name}        || die("Synthetic name missing for symbol, fix fx.yml");
    my $synthetic_info  = $synthetic->{components}  || die("Synthetic symbol missing components, fix fx.yml");

    my ($low, $high);
    my $op      = $synthetic_info->{op}         || die("op missing, fix fx.yml");
    my $leftop  = $synthetic_info->{leftop}     || die("leftopt missing, fix fx.yml");
    my $rightop = $synthetic_info->{rightop}    || die("rightop missing, fix fx.yml");
    if ($op eq '*') {
        $high   = 'high';
        $low    = 'low';
    } elsif ($op eq '/') {
        $high   = 'low';
        $low    = 'high';
    } else {
        die("Invalid op in components for synthetic. Fix fx.yml");
    }

    my $sql =
"insert ignore into $synthetic_name\_$timeframe (select T1.datetime, round(T1.open"
      . $op
      . "T2.open,4) as open, round(T1.low"
      . $op
      . "T2.$low,4) as low, round(T1.high"
      . $op
      . "T2.$high,4) as high, round(T1.close"
      . $op
      . "T2.close,4) as close from $leftop\_$timeframe as T1, $rightop\_$timeframe as T2 WHERE T1.datetime = T2.datetime)";
#AND T1.datetime > DATE_SUB(NOW(), INTERVAL 2 WEEK))
      $self->dbh->do($sql);
}

1;

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut
