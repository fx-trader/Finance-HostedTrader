#!/usr/bin/perl

=pod

# Sample query for multiple timeframes

SELECT TF_60.datetime, close_60, TF_300.datetime, close_300 FROM (
  SELECT datetime, CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 5) * 5, ':00') AS DATETIME) AS COMMON_DATETIME, close AS close_60,round(ta_sma(close,10), 4)
  FROM oanda_historical_EUR_USD_60
  WHERE datetime >= '2005-01-02 23:00:00 UTC' AND datetime < '2005-01-03 00:00:00 UTC'
  ORDER BY datetime
  LIMIT 10000000000
) AS TF_60

INNER JOIN (

  SELECT datetime, close AS close_300,round(ta_sma(close,10), 4)
  FROM oanda_historical_EUR_USD_300
  WHERE datetime >= '2005-01-02 23:00:00 UTC' AND datetime < '2005-01-03 00:00:00 UTC'
  ORDER BY datetime
  LIMIT 10000000000

) AS TF_300 ON TF_60.COMMON_DATETIME = TF_300.datetime
ORDER BY TF_60.datetime;

## Another example that uses only one base table
## but still has the problem of not doing running calculations in the higher timeframes
## ie, using this, the system would be looking into the future, ie:
## at 13:33 it would be using the close time from 13:34

SELECT TF60.datetime, TF60.close, TF60.SMA2, TF300.SMA2
FROM (
  SELECT datetime, CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 5) * 5, ':00') AS DATETIME) AS COMMON_DATETIME,
        close, round(ta_sma(close,2), 5) AS SMA2
  FROM oanda_historical_EUR_USD_60 AS TF60
  WHERE datetime >= '2005-06-02 13:30:00' AND datetime < '2005-06-02 13:40:00'
) AS TF60
LEFT JOIN (
  SELECT DATASET_300.datetime AS COMMON_DATETIME, DATASET_300.close, round(ta_sma(DATASET_300.close, 2), 5) AS SMA2
  FROM (
    SELECT
      CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 5) * 5, ':00') AS DATETIME) AS datetime,
      CAST(SUBSTRING_INDEX(GROUP_CONCAT(CAST(open AS CHAR) ORDER BY datetime), ',', 1) AS DECIMAL(10,4)) as open,
      MAX(high) as high,
      MIN(low) as low,
      CAST(SUBSTRING_INDEX(GROUP_CONCAT(CAST(close AS CHAR) ORDER BY datetime DESC), ',', 1) AS DECIMAL(10,4)) as close
    FROM oanda_historical_EUR_USD_300
    WHERE datetime >= '2005-06-02 13:30:00' AND datetime < '2005-06-02 13:40:00'
    GROUP BY CAST(CONCAT(year(datetime), '-', month(datetime), '-', day(datetime), ' ',  hour(datetime), ':', floor(minute(datetime) / 5) * 5, ':00') AS DATETIME)
    ORDER BY datetime ASC
  ) AS DATASET_300
) AS TF300
ON TF60.COMMON_DATETIME = TF300.COMMON_DATETIME;

=cut

use strict;
use warnings;

use Data::Dumper;
use Statistics::Descriptive;

use Finance::HostedTrader::ExpressionParser;

my $start_date  = '2005-01-01 00:00:00 UTC';
my $end_date    = '2006-01-01 00:00:00 UTC';

my $initial_balance = 10000;
my @trades;
my $live_trade;

my $data = get_data($start_date, $end_date);
my $account = { balance => $initial_balance };

my $i = 0;

while(1) {
    $i += int(rand(600));       # Move forward in time
    last if (!$data->[$i][0]);

    if ($live_trade) {
        if (is_close($live_trade)) {
            $live_trade->{close} = { price => $data->[$i][1], size => $live_trade->{open}{size}, datetime => $data->[$i][0] };
            my $stats = {};
            my $pl = ($live_trade->{close}{price} - $live_trade->{open}{price}) * $live_trade->{open}{size};
            $stats->{pl} = $pl;
            $stats->{return} = $pl / $account->{balance};
            $account->{balance} += $pl;

            $live_trade->{stats} = $stats;
            push @trades, $live_trade;
            $live_trade = undef;
        }
    } else {
        my $size = position_size();
        $size = 10000 if ($i > scalar(@$data) - 500 && !$size);
        if ($size) {
            $live_trade = { open => { price => $data->[$i][1], size => $size, datetime => $data->[$i][0] } };
        }
    }

};

my $analysis = analyse_trades(\@trades);

#print Dumper(\@trades);
print Dumper($analysis);
print "Final balance = $account->{balance}\n";

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
        average_win => $positive_pl->mean(),
        average_loss=> $negative_pl->mean(),
        largest_win => $positive_pl->max(),
        largest_loss=> $negative_pl->min(),
    };

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
            'sharpe'    => $system_stats->{return} / $system_stats->{volatility},
            'sortino'   => $system_stats->{return} / $negative_returns->standard_deviation,
        },
    };
    return $stats;
}

sub is_close {
    my $trade = shift;

    my $num = 1 + int(rand(100));
    return ($num > 50 ? 1 : 0);
}

sub position_size {

    my $probability = 90;

    my $num = -100 + int(rand(201));

    if ($num > $probability) {
        return 10000;
    } elsif ($num < -1*$probability) {
        return -10000;
    }

    return;
}

sub get_data {
    my ($start_date, $end_date) = @_;

    my $f = Finance::HostedTrader::ExpressionParser->new();

    my $data = $f->getIndicatorData(
        {
            'expression'    => 'datetime,close,sma(close,200)',
            'symbol'        => 'EUR_USD',
            'timeframe'     => 'min',
            'start_period'  => $start_date,
            'end_period'    => $end_date,
            'provider'      => 'oanda_historical',
        });

    return [ reverse(@{$data->{data}}) ];
}
