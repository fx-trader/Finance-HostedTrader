#!/usr/bin/perl

# ABSTRACT: Demo oanda v20 api
# PODNAME: fx-demo-oanda.pl

use strict;
use warnings;
$|=1;

use Finance::HostedTrader::Config;
use Getopt::Long;

my %options = (
    exclude  => [],
);

GetOptions(
    \%options,
    "help"      => sub { Getopt::Long::HelpMessage() },
    'exclude=s@',
) or Getopt::Long::HelpMessage(2);

my $cfg = Finance::HostedTrader::Config->new();


my $oanda = $cfg->provider('oanda');#Finance::HostedTrader::Provider::Oanda->new();

sub _getCurrencyRatio {
    my ($account_currency, $base_currency) = @_;

    return 1 if ($account_currency eq $base_currency);

    my $signal_processor = Finance::HostedTrader::ExpressionParser->new();
    my $params = {
        'expression'        => "datetime,close",
        'timeframe'         => "5min",
        'item_count'        => 1,
        'instrument'        => "${account_currency}_${base_currency}"
    };
    my $indicator_result    = $signal_processor->getIndicatorData($params);
    return $indicator_result->{data}[0][1];
}

sub get_account_risk {
    use Finance::HostedTrader::ExpressionParser;

    my $account_obj = $oanda->getAccountSummary();

    my $acc = $account_obj->{account};

    my $NAV = $acc->{NAV};
    my $account_currency = $acc->{currency};
    my %account_risk = (
        nav     => $NAV,
        leverage => sprintf("%.2f",$acc->{positionValue} / $NAV),
        position_value => $acc->{positionValue},
    );

    my $positions = $oanda->getOpenPositions();

    my $signal_processor = Finance::HostedTrader::ExpressionParser->new();
    my $params = {
        'expression'        => "datetime,previous(atr(14),1)",
        'timeframe'         => "day",
        'item_count'        => 1,
    };

    my $total_average_daily_volatility=0;
    foreach my $position (@{ $positions->{positions} }) {
        next if (grep { /$position->{instrument}/ } @{$options{exclude}});
        my $instrument = $oanda->convertInstrumentTo($position->{instrument});
        die("Don't know how to map $position->{instrument}") unless(defined($instrument));
        my $base_currency = $oanda->getInstrumentDenominator($instrument);

        my $currency_ratio      = _getCurrencyRatio($account_currency, $base_currency);
        $params->{instrument}   = $instrument || die("Could not map $instrument");
        my $indicator_result    = $signal_processor->getIndicatorData($params);
        my $atr14 = $indicator_result->{data}[0][1];
        my $positionSize = $position->{long}{units} - $position->{short}{units};
        my $average_daily_volatility = ($atr14 * $positionSize) / $currency_ratio;
        my $volatility_nav_ratio = $average_daily_volatility / $NAV;
        $total_average_daily_volatility += $average_daily_volatility;
        push @{ $account_risk{positions} }, {
            instrument                  => $oanda->convertInstrumentTo($position->{instrument}),
            daily_volatility            => sprintf("%.4f", $average_daily_volatility),
            daily_volatility_percent    => sprintf("%.6f", $volatility_nav_ratio),
        };
    }

    $account_risk{daily_volatility} = $total_average_daily_volatility;
    $account_risk{daily_volatility_percent} = $total_average_daily_volatility / $NAV;

    return \%account_risk;
}

my $o = get_account_risk();

#use Data::Dumper;
#print Dumper($o);
use DateTime;

if ($ARGV[0]) {
    print "${ \DateTime->now()->iso8601() }
Account NAV:\t\t$o->{nav}
Daily Volatility:\t${ \sprintf('%.2f', $o->{daily_volatility}) }
Expected range:\t\t${ \sprintf('%.2f', $o->{nav} - $o->{daily_volatility})} to ${ \sprintf( '%.2f', $o->{nav} + $o->{daily_volatility})}
";
} else {
    print DateTime->now()->iso8601()."Z,$o->{nav},$o->{position_value},$o->{leverage}," . sprintf('%.2f', $o->{daily_volatility}) . "," . sprintf('%.4f', $o->{daily_volatility_percent}) . "\n";
}
