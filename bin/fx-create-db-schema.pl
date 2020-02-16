#!/usr/bin/perl
# ABSTRACT: Outputs SQL suitable to create db, mysql users and tables to store instrument historical data in various timeframes
# PODNAME: fx-create-db-schema.pl

=head1 SYNOPSIS

    fx-create-db-schema.pl [--tableType=s] [--mode=simple|views] [--dropTables] [--help]

=head1 DESCRIPTION

=head2 OPTIONS

=over 12

=item C<--tableType=s>

A valid MariaDB table type. Defaults to MYISAM.

=item C<--mode=s>

simple - Create tables for all instruments/timeframes, including synthetic instruments (default).

views - Create table structure with views based on the lower timeframe.

=item C<--dropTables>

Optionally prefix CREATE TABLE IF NOT EXISTS statments with DROP TABLE IF EXISTS statments

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
use Finance::HostedTrader::Synthetics;
use Finance::HostedTrader::Provider;
use Pod::Usage;

my ( $drop_table, $help );
my ($mode, $table_type) = ('simple','MYISAM');
my $cfg = Finance::HostedTrader::Config->new();

my @provider_types = $cfg->getProviderNames();

my $result = GetOptions(
    "tableType=s",\$table_type,
    "mode=s",\$mode,
    "help", \$help,
    "dropTables", \$drop_table,
) or pod2usage(1);
pod2usage(1) if ($help);

my $dbname = $cfg->db->dbname;
my $dbuser = $cfg->db->dbuser;
my $dbpasswd = $cfg->db->dbpasswd;
my $userhost = '%';

#print "CREATE DATABASE IF NOT EXISTS $dbname;\n";
#print "GRANT ALL ON $dbname.* TO '$dbuser'\@'$userhost'" . ($dbpasswd ? " IDENTIFIED BY '$dbpasswd'": '') . ";\n";
print qq{
    use $dbname;
};


foreach my $provider_type (@provider_types) {

    my @tfs = sort { $a <=> $b } @{ $cfg->timeframes->all() };

    my $p = $cfg->providers->{$provider_type};
    my @instruments = $p->getInstruments();

    if ($mode eq 'simple') {

        foreach my $instrument (@instruments, $p->synthetic_names) {
            foreach my $tf (@tfs) {
                my $tableName = $p->getTableName($instrument, $tf);
                print "DROP TABLE IF EXISTS `$tableName`;\n" if ($drop_table);
                print qq /
    CREATE TABLE IF NOT EXISTS `$tableName` (
    `datetime` DATETIME NOT NULL ,
    `ask_open` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `ask_high` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `ask_low` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `ask_close` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `bid_open` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `bid_high` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `bid_low` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `bid_close` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `mid_open` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `mid_high` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `mid_low` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `mid_close` DECIMAL(12,6) UNSIGNED NOT NULL ,
    `volume` MEDIUMINT UNSIGNED NOT NULL ,
    PRIMARY KEY ( `datetime` )
    ) ENGINE = $table_type ;/;
            }
        }

    } else {

        my $lowerTf = shift(@tfs);


        foreach my $instrument (@instruments) {
            my $tableName = $p->getTableName($instrument, $lowerTf);
            print "DROP TABLE IF EXISTS `$tableName`;\n" if ($drop_table);
            print qq /
        CREATE TABLE IF NOT EXISTS `$tableName` (
        `datetime` DATETIME NOT NULL ,
        `ask_open` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `ask_high` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `ask_low` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `ask_close` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `bid_open` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `bid_high` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `bid_low` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `bid_close` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `mid_open` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `mid_high` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `mid_low` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `mid_close` DECIMAL(12,6) UNSIGNED NOT NULL ,
        `volume` MEDIUMINT UNSIGNED NOT NULL ,
        PRIMARY KEY ( `datetime` )
        ) ENGINE = $table_type ;
        /;
        }

        foreach my $instrument ($p->synthetic_names) {

            my $synthetic_info = $p->synthetic->{$instrument} || die("Don't know how to calculate $instrument. Add it to fx.yml");
            my $sql = Finance::HostedTrader::Synthetics::get_synthetic_instrument(provider => $p, instrument => $instrument, timeframe => $lowerTf, synthetic_info => $synthetic_info);
            my $tableName = $p->getTableName($instrument, $lowerTf);

            print qq /
        CREATE OR REPLACE VIEW $tableName AS
        ${sql};
        /;
        }

        foreach my $instrument (@instruments, $p->synthetic_names) {
            foreach my $tf (@tfs) {
                my $sql = Finance::HostedTrader::Synthetics::get_synthetic_timeframe(provider => $p, instrument => $instrument, timeframe => $tf);
                my $tableName = $p->getTableName($instrument, $tf);

        print qq/
        CREATE OR REPLACE VIEW $tableName AS
        $sql/;
            }
        }

    }

}

# print "GRANT ALL ON $dbname.* TO '$dbuser'@'$userhost'" . ($dbpasswd ? " IDENTIFIED BY '$dbpasswd'": '') . ";\n";
# The view that consists of an UNION of all instruments in the weekly timeframe was created with:

=pod

fx-all-tables.pl --provider=oanda_historical \
                 --timeframes=604800 \
                 --template="SELECT * FROM (SELECT 'INSTRUMENT_NAME' AS label, datetime, open, high, low, close, ta_rsi(close,14) AS RSI14 FROM TABLE_NAME ORDER BY datetime LIMIT 18446744073709551615) AS T" \
                 --join=$'\n'" UNION ALL "$'\n' \
                 --prefix "CREATE OR REPLACE VIEW PROVIDER_NAME_ALL_604800 AS " \
                 --suffix=";" | fx-db-client.pl

=cut

# To copy data from the oanda_historical_ tables to oanda_ tables use:
# time fx-all-tables.pl --providers=oanda --template "INSERT INTO TABLE_NAME SELECT * FROM ( SELECT * FROM oanda_historical_INSTRUMENT_NAME_TIMEFRAME_NAME ORDER BY datetime DESC LIMIT 50000) AS T ORDER BY datetime ASC;" | fx-db-client.pl
