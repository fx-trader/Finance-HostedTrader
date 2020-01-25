#!/usr/bin/perl

use strict;
use warnings;

use Log::Log4perl;
use Finance::HostedTrader::Datasource;
use Date::Manip;
use Data::Dumper;

my $log_level = $ENV{LOG_LEVEL} // 'INFO';
# Initialize Logger
my $log_conf = qq(
log4perl rootLogger = $log_level, SCREEN
log4perl.appender.SCREEN         = Log::Log4perl::Appender::Screen
log4perl.appender.SCREEN.stderr  = 0
log4perl.appender.SCREEN.layout  = Log::Log4perl::Layout::PatternLayout
log4perl.appender.SCREEN.layout.ConversionPattern = \%m \%n
#log4perl.appender.SCREEN.layout.ConversionPattern = \%d{ISO8601} \%m \%n
);

Log::Log4perl::init(\$log_conf);
my $l = Log::Log4perl->get_logger();


my $ds = Finance::HostedTrader::Datasource->new();
my $dbh = $ds->dbh;

my $lookback = 300;

$l->info("Start");

my @trades;
while ($lookback > 0) {
    my %trade;
    my $date = UnixDate(ParseDate("sunday $lookback weeks ago at midnight"), "%Y-%m-%d 00:00:00");
    #my $data = $dbh->selectrow_arrayref("SELECT label, RSI14 FROM oanda_historical_ALL_604800 WHERE DATETIME = '$date' AND RSI14 IS NOT NULL ORDER BY abs(50-RSI14) DESC LIMIT 1");
    my $data = ['NAS100_USD', 70];
    my $instrument = $data->[0];
    my $rsi_level = $data->[1];
    $l->info($date, "\t", join("\t", @$data));
    $lookback--;

    my $start_date = UnixDate(ParseDate("sunday $lookback weeks ago at midnight"), "%Y-%m-%d 00:00:00");
    my $open = get_open($instrument, $start_date);
    if (!$open) {
        $l->info("Not opening trade for $instrument");
        next;
    }

    $trade{instrument} = $instrument;
    $trade{open} = { datetime => $open->[0], price => $open->[1], size => ( $rsi_level > 50 ? 1 : -1 ) };
    $l->info("Open $trade{open}{size} units of $instrument on $trade{open}{datetime} at price $trade{open}{price}");

    get_close(\%trade, $start_date);
    $l->info("Close $instrument on $trade{close}{datetime} at price $trade{close}{price}");
    push @trades, \%trade;
}

print Dumper(\@trades);

$l->info("Done");

sub get_close {
my $trade = shift;
my $start_date = shift;

my $instrument = $trade->{instrument};
my $trade_open_date = $trade->{open}{datetime} || $l->logconfess("Trade open date undefined");
my $open_price = $trade->{open}{price};

my $sql = "
WITH T AS (
  SELECT datetime, close
  FROM oanda_historical_${instrument}_60
  WHERE datetime > '$trade_open_date' and datetime <= DATE_ADD('$start_date' , INTERVAL 7 DAY)
  AND (low <= $open_price * 0.97 OR high >= $open_price * 1.03)
  ORDER BY datetime ASC
  LIMIT 1
),
LAST_CLOSE AS (
  SELECT datetime, close
  FROM oanda_historical_${instrument}_60
  WHERE datetime > '$trade_open_date' and datetime <= DATE_ADD('$start_date' , INTERVAL 7 DAY)
  ORDER BY datetime DESC
  LIMIT 1
)
SELECT * FROM T
UNION ALL
SELECT * FROM LAST_CLOSE
ORDER BY datetime
LIMIT 1
";

my $data = $dbh->selectrow_arrayref($sql) // $l->logconfess($!);
$trade->{close} = { datetime => $data->[0], price => $data->[1] };
}

sub get_open {
    my ($instrument, $start_date) = @_;

$l->info("Start date = $start_date");
$l->info("Instrument = $instrument");

my $sql="
WITH T AS (
    SELECT * FROM
    oanda_historical_${instrument}_60
    WHERE datetime >= '$start_date' and datetime <= DATE_ADD('$start_date', INTERVAL 7 DAY)
    ORDER BY datetime ASC
    LIMIT 185000000
),
FILTER AS (
  SELECT datetime,
  CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 30) * 30, ':00') AS DATETIME) AS COMMON_DATETIME,
  open, high, low, close,
  round(ta_rsi_win(close, 14) OVER (PARTITION BY COMMON_DATETIME ORDER BY datetime), 5) AS RSI
  FROM T
)
SELECT datetime, open, RSI FROM FILTER
WHERE FILTER.datetime >= (SELECT datetime FROM FILTER WHERE RSI < 25  LIMIT 1)
ORDER BY FILTER.datetime
LIMIT 2
";
my $data = $dbh->selectall_arrayref($sql) // $l->logconfess($!);

return if (!@$data);

$data->[1][2] = $data->[0][2]; # Return 'previous' period RSI value that triggered 'this' period open

return $data->[1];
}
