package Finance::HostedTrader::Synthetics;
# ABSTRACT: Finance::Synthetics - Framework Helper functions for dealing with synthetic symbols/timeframes

=head1 SYNOPSIS
=cut

use strict;
use warnings;

my $lowerTf = 300;
my %tfMap = (
    300 => {
        date_format => "CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 5) * 5, ':00') AS DATETIME)",
    },
    900 => {
        date_format => "CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 15) * 15, ':00') AS DATETIME)",
    },
    1800 => {
        date_format => "CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 30) * 30, ':00') AS DATETIME)",
    },
    3600 => {
        date_format => "date_format(datetime, '%Y-%m-%d %H:00:00')",
    },
    7200 => {
        date_format => "CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  floor(hour(datetime) / 2) * 2, ':00:00') AS DATETIME)",
    },
    10800 => {
        date_format => "CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  floor(hour(datetime) / 3) * 3, ':00:00') AS DATETIME)",
    },
    14400 => {
        date_format => "CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  floor(hour(datetime) / 4) * 4, ':00:00') AS DATETIME)",
    },
    86400 => {
        date_format => "date_format(datetime, '%Y-%m-%d 00:00:00')",
        where_clause => "dayofweek(datetime) != 1",
    },
    604800 => {
        date_format => "date_format(date_sub(datetime, interval weekday(datetime)+1 DAY), '%Y-%m-%d 00:00:00')",
        date_group  => "date_format(datetime, '%x-%v')",
    },
);

sub get_synthetic_symbol {
    my %options = @_;

    my $synthetic_info  = $options{synthetic_info};
    my $symbol          = $options{symbol};
    my $tf              = $options{timeframe};
    my $incremental_base_table  = $options{incremental_base_table};
    my $incremental_sql_filter = "";

    if ($incremental_base_table) {
        $incremental_sql_filter = _get_incremental_where_clause($incremental_base_table);
    }

    my $op = $synthetic_info->{op};
    my $leftop = $synthetic_info->{leftop};
    my $rightop = $synthetic_info->{rightop};
    my ($sql, $high, $low);

    if ( $op eq '*' ) {
        $high   = 'high';
        $low    = 'low';
    } elsif ( $op eq '/' ) {
        $high   = 'low';
        $low    = 'high';
    } else {
        die("Invalid op component for synthetic $symbol . Fix fx.yml.");
    }

    if ($leftop ne '1') {

        if ($incremental_sql_filter) {
            $incremental_sql_filter = "AND T1.$incremental_sql_filter ";
        }
        $sql = qq{
            SELECT T1.datetime,
            ROUND(T1.open $op T2.open,4) AS open,
            ROUND(T1.high $op T2.${high},4) AS high,
            ROUND(T1.low  $op T2.${low},4) AS low,
            ROUND(T1.close $op T2.close,4) AS close
            FROM ${leftop}_${tf} AS T1, ${rightop}_${tf} AS T2
            WHERE T1.datetime = T2.datetime $incremental_sql_filter
        };

    } else {

        if ($incremental_sql_filter) {
            $incremental_sql_filter = "WHERE T2.$incremental_sql_filter ";
        }
        $sql = qq{
            SELECT T2.datetime,
            ROUND(1 $op T2.open,4) AS open,
            ROUND(1 $op T2.${high},4) AS high,
            ROUND(1 $op T2.${low},4) AS low,
            ROUND(1 $op T2.close,4) AS close
            FROM $rightop\_$tf AS T2
            $incremental_sql_filter
            ORDER BY T2.datetime DESC
        };

    }

    return $sql;
}

sub get_synthetic_timeframe {
    my %options = @_;
    my $symbol = $options{symbol} || die("missing symbol");
    my $tf = $options{timeframe} || die("missing timeframe");
    my $incremental_base_table  = $options{incremental_base_table};

    my $date_format = $tfMap{$tf}->{date_format};
    my $date_group  = $tfMap{$tf}->{date_group} || $date_format;
    my $where_clause= $tfMap{$tf}->{where_clause};

    if ($incremental_base_table) {
        my $incremental_sql_filter = _get_incremental_where_clause($incremental_base_table);

        $where_clause = ( $where_clause ? " AND $incremental_sql_filter " : $incremental_sql_filter);
    }

    $where_clause = ( $where_clause ? "WHERE $where_clause" : "" );

    return qq/SELECT
      $date_format AS datetime,
      CAST(SUBSTRING_INDEX(GROUP_CONCAT(CAST(open AS CHAR) ORDER BY datetime), ',', 1) AS DECIMAL(9,4)) as open,
      MAX(high) as high,
      MIN(low) as low,
      CAST(SUBSTRING_INDEX(GROUP_CONCAT(CAST(close AS CHAR) ORDER BY datetime DESC), ',', 1) AS DECIMAL(9,4)) as close
    FROM ${symbol}_${lowerTf}
    $where_clause
    GROUP BY $date_group
    ORDER BY datetime DESC;
/;

}

sub _get_incremental_where_clause {
    my $incremental_base_table = shift;

    return qq/datetime >= (
        SELECT IFNULL((
            SELECT datetime FROM (
            SELECT datetime
            FROM ${incremental_base_table}
            ORDER BY datetime DESC
            LIMIT 2
            ) AS T
            ORDER BY datetime ASC
            LIMIT 1),
        '0001-01-01 00:00:00'))/;

}

1;
