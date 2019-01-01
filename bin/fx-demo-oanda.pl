#!/usr/bin/perl

# ABSTRACT: Demo oanda v20 api
# PODNAME: fx-demo-oanda.pl

use strict;
use warnings;
$|=1;

use Finance::HostedTrader::Config;
use Finance::HostedTrader::Provider::Oanda;

my %instrumentMap = (
    AUDCAD => 'AUD_CAD',
    AUDCHF => 'AUD_CHF',
    AUDJPY => 'AUD_JPY',
    AUDNZD => 'AUD_NZD',
    AUDUSD => 'AUD_USD',
    AUS200 => 'AUS200',
    CADCHF => 'CAD_CHF',
    CADJPY => 'CAD_JPY',
    CHFJPY => 'CHF_JPY',
    CHFNOK => 'CHF_NOK',
    CHFSEK => 'CHF_SEK',
    EURAUD => 'EUR_AUD',
    EURCAD => 'EUR_CAD',
    EURCHF => 'EUR_CHF',
    EURDKK => 'EUR_DKK',
    EURGBP => 'EUR_GBP',
    EURJPY => 'EUR_JPY',
    EURNOK => 'EUR_NOK',
    EURNZD => 'EUR_NZD',
    EURSEK => 'EUR_SEK',
    EURTRY => 'EUR_TRY',
    EURUSD => 'EUR_USD',
    GBPAUD => 'GBP_AUD',
    GBPCAD => 'GBP_CAD',
    GBPCHF => 'GBP_CHF',
    GBPJPY => 'GBP_JPY',
    GBPNZD => 'GBP_NZD',
    GBPSEK => 'GBP_SEK',
    GBPUSD => 'GBP_USD',
    HKDJPY => 'HKD_JPY',
    NOKJPY => 'NOK_JPY',
    NZDCAD => 'NZD_CAD',
    NZDCHF => 'NZD_CHF',
    NZDJPY => 'NZD_JPY',
    NZDUSD => 'NZD_USD',
    SEKJPY => 'SEK_JPY',
    SGDJPY => 'SGD_JPY',
    TRYJPY => 'TRY_JPY',
    USDCAD => 'USD_CAD',
    USDCHF => 'USD_CHF',
    USDDKK => 'USD_DKK',
    USDHKD => 'USD_HKD',
    USDJPY => 'USD_JPY',
    USDMXN => 'USD_MXN',
    USDNOK => 'USD_NOK',
    USDSEK => 'USD_SEK',
    USDSGD => 'USD_SGD',
    USDTRY => 'USD_TRY',
    USDZAR => 'USD_ZAR',
    XAGEUR => 'XAG_EUR',
    XAGUSD => 'XAG_USD',
    XAUUSD => 'XAU_USD',
    ZARJPY => 'ZAR_JPY',
    ESP35  => 'ESP35',
    FRA40  => 'FRA40',
    GER30  => 'GER30',
    HKG33  => 'HKG33',
    ITA40  => 'ITA40',
    JPN225 => 'JPN225',
    NAS100 => 'NAS100_USD',
    SPX500 => 'SPX500_USD',
    SUI30  => 'SUI30',
    SWE30  => 'SWE30',
    UK100  => 'UK100',
    UKOil  => 'BCO_USD',
    US30   => 'US30',
    USOil  => 'WTICO_USD',
    Corn   => 'CORN_USD',
    Wheat  => 'WHEAT_USD',
    Copper => 'Copper',
    XPTUSD => 'XPT_USD',
    XPDUSD => 'CPD_USD',
    USDOLLAR=> 'USDOLLAR',
    NGAS    => 'NGAS',
    EUSTX50 => 'EUSTX50',
    Bund    => 'Bund',
);

my %reverseInstrumentMap = map { $instrumentMap{$_} => $_ } keys %instrumentMap;

my $cfg = Finance::HostedTrader::Config->new();


my $oanda = Finance::HostedTrader::Provider::Oanda->new();

sub _getCurrencyRatio {
    my ($account_currency, $base_currency) = @_;

    return 1 if ($account_currency eq $base_currency);

    my $signal_processor = Finance::HostedTrader::ExpressionParser->new();
    my $params = {
        'expression'        => "datetime,close",
        'timeframe'         => "5min",
        'item_count'        => 1,
        'symbol'            => "${account_currency}${base_currency}"
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
        next if ($position->{instrument} eq 'CORN_USD' || $position->{instrument} eq 'WHEAT_USD');
        my $instrument = $reverseInstrumentMap{$position->{instrument}};
        die("Don't know how to map $position->{instrument}") unless(defined($instrument));
        my $base_currency = $cfg->symbols->getSymbolDenominator($instrument);

        my $currency_ratio      = _getCurrencyRatio($account_currency, $base_currency);
        $params->{symbol}       = $instrument || die("Could not map $instrument");
        my $indicator_result    = $signal_processor->getIndicatorData($params);
        my $atr14 = $indicator_result->{data}[0][1];
        my $positionSize = $position->{long}{units} - $position->{short}{units};
        my $average_daily_volatility = ($atr14 * $positionSize) / $currency_ratio;
        my $volatility_nav_ratio = $average_daily_volatility / $NAV;
        $total_average_daily_volatility += $average_daily_volatility;
        push @{ $account_risk{positions} }, {
            instrument                  => $reverseInstrumentMap{$position->{instrument}},
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
