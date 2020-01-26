#!/usr/bin/perl

use strict;
use warnings;

use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Config;

my $oanda = Finance::HostedTrader::Config->new()->providers->{oanda};
my $instruments = $oanda->getInstrumentsFromProvider;

use Log::Log4perl;
use Date::Manip;
use Statistics::Descriptive;
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

my %account = ( balance => 10000, currency => 'GBP' );
my %system = ( trades => [] );
my @trades;

while ($lookback > 0) {
    my %trade;
    my $date = UnixDate(ParseDate("sunday $lookback weeks ago at midnight"), "%Y-%m-%d 00:00:00");
    my $data = $dbh->selectrow_arrayref("SELECT label, RSI14 FROM oanda_historical_ALL_604800 WHERE DATETIME = '$date' AND RSI14 IS NOT NULL ORDER BY abs(50-RSI14) DESC LIMIT 1");
    #my $data = ['NAS100_USD', 70];
    my $instrument = $data->[0];
    my $rsi_level = $data->[1];
    $l->info($date, "\t", join("\t", @$data));
    $lookback--;

    if (!$instruments->{$instrument}) {
        $l->warn("Provider does not support $instrument, skipping trade");
        next;
    }

    my $start_date = UnixDate(ParseDate("sunday $lookback weeks ago at midnight"), "%Y-%m-%d 00:00:00");
    my $open = get_open($instrument, $start_date);
    if (!$open) {
        $l->warn("Not opening trade for $instrument because open signal was not triggered in the requested period");
        next;
    }

    $trade{instrument} = $instrument;

    my $size;
    $trade{open} = { datetime => $open->[0], price => $open->[1], size => ( $rsi_level > 50 ? 1 : -1 ) };
    #$l->info("Open $trade{open}{size} units of $instrument on $trade{open}{datetime} at price $trade{open}{price}");

    get_close(\%trade, $start_date);

    my $pl = ps( $instruments->{$instrument}{pipLocation} ) * ($trade{close}->{price} - $trade{open}->{price}) * $trade{open}->{size};
    $l->info("$instrument, OpenDate = $trade{open}{datetime}, OpenPrice = $trade{open}{price}, PositionSize = $trade{open}{size}, CloseDate = $trade{close}{datetime}, Close Price = $trade{close}{price}, pl = $pl");
    $trade{stats} = { return => $pl / $account{balance}, pl => $pl};
    push @{ $system{trades} }, \%trade;
}

sub ps {
    my $pipLocation = shift;

    if (!defined($pipLocation)) {
        $l->logconfess("undef");
    }

    if ($pipLocation == -4) {
        return 10000;
    } elsif ($pipLocation == -3) {
        return 1000;
    } elsif ($pipLocation == -2) {
        return 100;
    } elsif ($pipLocation == -1) {
        return 10;
    } elsif ($pipLocation == 0) {
        return 1;
    } elsif ($pipLocation == 1) {
        return 0.1;
    } else {
        $l->logconfess("Don't know how to calculate pipLocation = $pipLocation");
    }
}

print Dumper(\%system);
my $analysis = analyse_trades($system{trades});
print Dumper($analysis);

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

sub analyse_trades {
    my $trades = shift;

    my @winners = grep { $_->{stats}{pl} > 0 } @$trades;
    my @loosers = grep { $_->{stats}{pl} < 0 } @$trades;
    my @neutral = grep { $_->{stats}{pl} == 0 } @$trades;

    my $trade_returns       = Statistics::Descriptive::Full->new();
    my $positive_returns    = Statistics::Descriptive::Full->new();
    my $negative_returns    = Statistics::Descriptive::Full->new();
    my $positive_pl         = Statistics::Descriptive::Full->new();
    my $negative_pl         = Statistics::Descriptive::Full->new();

    $trade_returns->add_data( map { $_->{stats}{return} } @$trades );
    $positive_returns->add_data( map { $_->{stats}{return} } @winners );
    $negative_returns->add_data( map { $_->{stats}{return} } @loosers );
    $positive_pl->add_data( map {$_->{stats}{pl} } @winners );
    $negative_pl->add_data( map {$_->{stats}{pl} } @loosers );

    my $trade_stats = {
        total       => scalar(@$trades),
        winners     => scalar(@winners),
        loosers     => scalar(@loosers),
        neutral     => scalar(@neutral),
        win_percent => scalar(@winners) / scalar(@$trades),
        loss_percent=> scalar(@loosers) / scalar(@$trades),
        average_win => $positive_pl->mean() // 0,
        average_loss=> $negative_pl->mean() // 0,
        largest_win => $positive_pl->max() // 0,
        largest_loss=> $negative_pl->min() // 0,
    };

    my $initial_balance = $account{balance};
    my $balance = $initial_balance;
    my $max_drawdown = 0;
    my $balance_high = $balance;

    foreach my $trade (@$trades) {
        $balance += $trade->{stats}{pl};
        if ($balance > $balance_high) {
            $balance_high = $balance;
        } else {
            my $current_drawdown = $balance_high - $balance;
            if ($current_drawdown > $max_drawdown) {
                $max_drawdown = $current_drawdown;
            }
        }
    }

    my $system_stats = {
        expectancy    => ($trade_stats->{win_percent} * $trade_stats->{average_win}) + ($trade_stats->{loss_percent} * $trade_stats->{average_loss}),
        max_drawdown  => $max_drawdown,
        return        => ( $balance / $initial_balance) - 1,
        volatility    => $trade_returns->standard_deviation,
    };

    my $stats = {
        trades  => $trade_stats,
        system  => $system_stats,
        ratios  => {
            'sharpe'    => ($system_stats->{volatility} ? $system_stats->{return} / $system_stats->{volatility} : undef),
            'sortino'   => ($negative_returns->standard_deviation ? $system_stats->{return} / $negative_returns->standard_deviation : undef),
        },
    };
    return $stats;
}

