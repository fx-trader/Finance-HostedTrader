#!/usr/bin/perl
# ABSTRACT: Outputs SQL suitable to create db, mysql users and tables to store symbol historical data in various timeframes
# PODNAME: fx-create-db-schema.pl

=head1 SYNOPSIS

    fx-create-db-schema.pl [--tableType=s] [--mode=simple|views] [--dropTables] [--help]

=head1 DESCRIPTION

=head2 OPTIONS

=over 12

=item C<--tableType=s>

A valid MariaDB table type. Defaults to MYISAM.

=item C<--mode=s>

simple - Create tables for all symbols/timeframes, including synthetic symbols (default).

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

print qq{
    use $dbname;
};


foreach my $provider_type (@provider_types) {

    my @tfs = sort { $a <=> $b } @{ $cfg->timeframes->all() };

    my $p = $cfg->providers->{$provider_type};
    my @symbols = $p->getInstruments();

    if ($mode eq 'simple') {

        foreach my $symbol (@symbols, $p->synthetic_names) {
            foreach my $tf (@tfs) {
                my $tableName = $p->getTableName($symbol, $tf);
                print "DROP TABLE IF EXISTS `$tableName`;\n" if ($drop_table);
                print qq /
    CREATE TABLE IF NOT EXISTS `$tableName` (
    `datetime` DATETIME NOT NULL ,
    `open` DECIMAL(10,4) NOT NULL ,
    `high` DECIMAL(10,4) NOT NULL ,
    `low` DECIMAL(10,4) NOT NULL ,
    `close` DECIMAL(10,4) NOT NULL ,
    PRIMARY KEY ( `datetime` )
    ) ENGINE = $table_type ;/;
            }
        }

    } else {

        my $lowerTf = shift(@tfs);


        foreach my $symbol (@symbols) {
            my $tableName = $p->getTableName($symbol, $lowerTf);
            print "DROP TABLE IF EXISTS `$tableName`;\n" if ($drop_table);
            print qq /
        CREATE TABLE IF NOT EXISTS `$tableName` (
        `datetime` DATETIME NOT NULL ,
        `open` DECIMAL(10,4) NOT NULL ,
        `high` DECIMAL(10,4) NOT NULL ,
        `low` DECIMAL(10,4) NOT NULL ,
        `close` DECIMAL(10,4) NOT NULL ,
        PRIMARY KEY ( `datetime` )
        ) ENGINE = $table_type ;
        /;
        }

        foreach my $symbol ($p->synthetic_names) {

            my $synthetic_info = $p->synthetic->{$symbol} || die("Don't know how to calculate $symbol. Add it to fx.yml");
            my $sql = Finance::HostedTrader::Synthetics::get_synthetic_symbol(provider => $p, symbol => $symbol, timeframe => $lowerTf, synthetic_info => $synthetic_info);
            my $tableName = $p->getTableName($symbol, $lowerTf);

            print qq /
        CREATE OR REPLACE VIEW $tableName AS
        ${sql};
        /;
        }

        foreach my $symbol (@symbols, $p->synthetic_names) {
            foreach my $tf (@tfs) {
                my $sql = Finance::HostedTrader::Synthetics::get_synthetic_timeframe(provider => $p, symbol => $symbol, timeframe => $tf);
                my $tableName = $p->getTableName($symbol, $tf);

        print qq/
        CREATE OR REPLACE VIEW $tableName AS
        $sql/;
            }
        }

    }

}

# print "GRANT ALL ON $dbname.* TO '$dbuser'@'$userhost'" . ($dbpasswd ? " IDENTIFIED BY '$dbpasswd'": '') . ";\n";
# The view that consists of an UNION of all instruments in the weekly timeframe was created with:
# fx-all-tables.pl --provider=oanda --timeframes=604800 --template="SELECT *, 'TABLE_NAME' AS label FROM TABLE_NAME" --join=$'\n'" UNION ALL "$'\n' --prefix "CREATE OR REPLACE VIEW oanda_ALL_604800 AS " --suffix=";" | fx-db-client.pl

=pod


=cut

