#!/usr/bin/perl
# ABSTRACT: Outputs SQL suitable to create db, mysql users and tables to store symbol historical data in various timeframes
# PODNAME: fx-create-db-schema.pl

=head1 SYNOPSIS

    fx-create-db-schema.pl [--timeframes=tfs] [--help] [--symbols=s]

=head1 DESCRIPTION

=head2 OPTIONS

=over 12

=item C<--tableType=s>

A valid mysql table type. Defaults to MYISAM.

=item C<--timeframes=tfs>

A comma separated list of timeframe ids to generate SQL for.
If not supplied, defaults all timeframes (natural and synthetic) defined in the config file.

=item C<--symbols=s>

Comma separated list of symbols to generate SQL for.
If not supplied, defaults all symbols (natural and synthetic) defined in the config file.

=item C<--help>

Display usage information.

=back

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut

use strict;
use warnings;
use Getopt::Long;
use Finance::HostedTrader::Config;
use Pod::Usage;

my ( $symbols_txt, $tfs_txt, $drop_table, $help );
my ($table_type) = ('MYISAM');
my $cfg = Finance::HostedTrader::Config->new();

my $result = GetOptions( "symbols=s", \$symbols_txt, "timeframes=s", \$tfs_txt, "tableType=s", \$table_type, "help", \$help, "dropTables", \$drop_table)
  or pod2usage(1);
pod2usage(1) if ($help);

my @tfs = sort { $a <=> $b } @{ $cfg->timeframes->all() };
@tfs = split( ',', $tfs_txt ) if ($tfs_txt);
my $lowerTf = shift(@tfs);

my $symbols = $cfg->symbols->all();
$symbols = [ split( ',', $symbols_txt ) ] if ($symbols_txt);
my $dbname = $cfg->db->dbname;
my $dbuser = $cfg->db->dbuser;
my $dbpasswd = $cfg->db->dbpasswd;
my $userhost = '%';

print qq{
    use $dbname;
};

foreach my $symbol (@$symbols) {
    print "DROP TABLE IF EXISTS `$symbol\_$lowerTf`;\n" if ($drop_table);
    print qq /
CREATE TABLE IF NOT EXISTS `${symbol}_${lowerTf}` (
`datetime` DATETIME NOT NULL ,
`open` DECIMAL(9,4) NOT NULL ,
`high` DECIMAL(9,4) NOT NULL ,
`low` DECIMAL(9,4) NOT NULL ,
`close` DECIMAL(9,4) NOT NULL ,
PRIMARY KEY ( `datetime` )
) ENGINE = $table_type ;
/;
}

my %tfMap = (
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

foreach my $symbol (@$symbols) {
    foreach my $tf (@tfs) {
        my $date_format = $tfMap{$tf}->{date_format};
        my $date_group  = $tfMap{$tf}->{date_group} || $date_format;
        my $where_clause= $tfMap{$tf}->{where_clause};
        $where_clause = ( $where_clause ? "WHERE $where_clause" : "" );

print qq/
CREATE OR REPLACE VIEW ${symbol}_${tf} AS
    SELECT
      $date_format AS datetime,
      CAST(SUBSTRING_INDEX(GROUP_CONCAT(CAST(open AS CHAR) ORDER BY datetime), ',', 1) AS DECIMAL(9,4)) as open,
      MAX(high) as high,
      MIN(low) as low,
      CAST(SUBSTRING_INDEX(GROUP_CONCAT(CAST(close AS CHAR) ORDER BY datetime DESC), ',', 1) AS DECIMAL(9,4) )as close
    FROM ${symbol}_${lowerTf}
    $where_clause
    GROUP BY $date_group
    ORDER BY datetime DESC;
/;
    }
}
# print "GRANT ALL ON $dbname.* TO '$dbuser'@'$userhost'" . ($dbpasswd ? " IDENTIFIED BY '$dbpasswd'": '') . ";\n";
