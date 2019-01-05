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

my @provider_types = sort keys %{ $cfg->providers };

my $result = GetOptions(
    "tableType=s",\$table_type,
    "mode=s",\$mode,
    "help", \$help,
    "dropTables", \$drop_table,
) or pod2usage(1);
pod2usage(1) if ($help);

my @tfs = sort { $a <=> $b } @{ $cfg->timeframes->all() };

my $symbols_synthetic = $cfg->symbols->synthetic();
my $dbname = $cfg->db->dbname;
my $dbuser = $cfg->db->dbuser;
my $dbpasswd = $cfg->db->dbpasswd;
my $userhost = '%';

print qq{
    use $dbname;
};


foreach my $provider_type (@provider_types) {

    my $p = Finance::HostedTrader::Provider->factory($provider_type);
    my @symbols = map { "${provider_type}_${_}" } $p->getInstruments();

    if ($mode eq 'simple') {

        foreach my $symbol (@symbols, keys %$symbols_synthetic) {
            foreach my $tf (@tfs) {
                print "DROP TABLE IF EXISTS `$symbol\_$tf`;\n" if ($drop_table);
                print qq /
    CREATE TABLE IF NOT EXISTS `${symbol}_${tf}` (
    `datetime` DATETIME NOT NULL ,
    `open` DECIMAL(9,4) NOT NULL ,
    `high` DECIMAL(9,4) NOT NULL ,
    `low` DECIMAL(9,4) NOT NULL ,
    `close` DECIMAL(9,4) NOT NULL ,
    PRIMARY KEY ( `datetime` )
    ) ENGINE = $table_type ;/;
            }
        }

    } else {

        my $lowerTf = shift(@tfs);


        foreach my $symbol (@symbols) {
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

        foreach my $symbol (keys %$symbols_synthetic) {

            my $synthetic_info = $cfg->symbols->synthetic->{$symbol} || die("Don't know how to calculate $symbol. Add it to fx.yml");
            my $sql = Finance::HostedTrader::Synthetics::get_synthetic_symbol(symbol => $symbol, timeframe => $lowerTf, synthetic_info => $synthetic_info);

            print qq /
        CREATE OR REPLACE VIEW ${symbol}_${lowerTf} AS
        ${sql};
        /;
        }

        foreach my $symbol (@symbols, keys %$symbols_synthetic) {
            foreach my $tf (@tfs) {
                my $sql = Finance::HostedTrader::Synthetics::get_synthetic_timeframe(symbol => $symbol, timeframe => $tf);

        print qq/
        CREATE OR REPLACE VIEW ${symbol}_${tf} AS
        $sql/;
            }
        }

    }

}

# print "GRANT ALL ON $dbname.* TO '$dbuser'@'$userhost'" . ($dbpasswd ? " IDENTIFIED BY '$dbpasswd'": '') . ";\n";

=pod


=cut

