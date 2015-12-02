#!/usr/bin/perl

# PODNAME: fx-trend.pl
# ABSTRACT: List assets sorted by trend

=head1 SYNOPSIS

    fx-trend.pl [--separator=' '] [--average=i] [--numItems=i]


=head1 DESCRIPTION

Sample expressions:

rsi(close,14)

ema(close,21)


=head2 OPTIONS

=over 12

=item C<--average=i>

Optional. If specified, average the trend values by an EMA of i periods.

=item C<--separator=s>

Optional argument. Output column separator, defaults to single space

=item C<--numItems=i>

Optional argument. Number of data points to output per symbol. Defaults to 1.


=back

=head1 SEE ALSO

L<Finance::HostedTrader::Datasource>

=cut



use strict;
use warnings;

use Finance::HostedTrader::ExpressionParser;
use Finance::HostedTrader::Config;

use Getopt::Long;

my ( $separator, $max_loaded_items, $average, $numItems ) = ( ' ', 1000, 1, 1 );

my $result = GetOptions(
    "separator=s",          \$separator,
    "average=i",            \$average,
    "numItems=i",           \$numItems,
) || exit(1);

my $signal_processor = Finance::HostedTrader::ExpressionParser->new();
my $c = Finance::HostedTrader::Config->new();
my $symbols = $c->symbols->get_symbols_by_denominator("USD");
my $dbh = $signal_processor->{_ds}->dbh;


foreach my $symbol ( @$symbols ) {
    my $asset = $c->symbols->getSymbolNumerator($symbol);
    my $sql = getSQL($symbol, $average, $numItems);
    my $data = $dbh->selectall_arrayref($sql) or die($DBI::errstr);

    if (!defined($data) || !defined($data->[0]) || !defined($data->[0]->[1])) {
        warn "$sql\n";
        die("No data for $symbol");
    }

    foreach my $row (@$data) {
        print $asset, $separator, $row->[0], $separator, $row->[1], "\n";
    }

}

$symbols = $c->symbols->get_symbols_by_numerator("USD");
foreach my $symbol ( @$symbols ) {
    my $asset = $c->symbols->getSymbolDenominator($symbol);
    my $sql = getSQL($symbol, $average, $numItems);
    my $data = $dbh->selectall_arrayref($sql) or die($DBI::errstr);

    if (!defined($data) || !defined($data->[0]) || !defined($data->[0]->[1])) {
        warn "$sql\n";
        die("No data for $symbol");
    }

    foreach my $row (@$data) {
        $row->[1] = $row->[1] * (-1);
        print $asset, $separator, $row->[0], $separator, $row->[1], "\n";
    }

}


sub getSQL {
    my ($symbol, $average, $numItems) = @_;

# The inner query converts 5 minute data to weekly format, and returns at most 1000 rows of weekly data
# See this article for more details on this technique: http://zonalivre.org/2009/10/12/simulating-firstlast-aggregate-functions-in-mysql/

# The outer query calculates the trend score for the weekly data.
# The formula for the trend score is: ema( ((close-ema(close,21) / standard deviation ?), x  )
# where x is the smoothing factor, with x=1 meaning no smoothing

    my $sql = qq|
(
    SELECT date_format(`datetime`, '%Y-%m-%d') AS `datetime`,
            round(ta_ema(round((close - ta_sma(close,21)) / (SQRT(ta_sum(POW(close - ta_sma(close, 21), 2), 21)/21)), 2), $average), 4)
    FROM (

            SELECT  date_format(date_sub(datetime, interval weekday(datetime)-5 DAY), '%Y-%m-%d 00:00:00') as datetime,
                    CAST(SUBSTRING_INDEX(GROUP_CONCAT(CAST(close AS CHAR) ORDER BY datetime DESC), ',', 1) AS DECIMAL(10,4)) as close
            FROM ${symbol}_300
            WHERE datetime < '2015-11-28'
            GROUP BY date_format(datetime, '%x-%v')
            ORDER BY datetime ASC
            LIMIT 1000

    ) AS T_CONVERT_5MIN_TO_WEEKLY
    WHERE datetime >= '0001-01-31'
    ORDER BY datetime ASC

)
ORDER BY datetime DESC
LIMIT $numItems

|;

    return $sql;
}
