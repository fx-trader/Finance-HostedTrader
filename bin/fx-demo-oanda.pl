#!/usr/bin/perl

# ABSTRACT: Demo oanda v20 api
# PODNAME: fx-demo-oanda.pl

use strict;
use warnings;
$|=1;

use Finance::HostedTrader::Config;
use REST::Client;
use File::Slurp;
use JSON::MaybeXS;
use URI::Query;

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
    XAGUSD => 'XAG_USD',
    XAUUSD => 'XAU_USD',
    ZARJPY => 'ZAR_JPY',
    ESP35  => 'ESP35',
    FRA40  => 'FRA40',
    GER30  => 'GER30',
    HKG33  => 'HKG33',
    ITA40  => 'ITA40',
    JPN225 => 'JPN225',
    NAS100 => 'NAS100',
    SPX500 => 'SPX500',
    SUI30  => 'SUI30',
    SWE30  => 'SWE30',
    UK100  => 'UK100',
    UKOil  => 'UKOil',
    US30   => 'US30',
    USOil  => 'WTICO_USD',
    Copper => 'Copper',
    XPTUSD => 'XPT_USD',
    XPDUSD => 'CPD_USD',
    USDOLLAR=> 'USDOLLAR',
    NGAS    => 'NGAS',
    EUSTX50 => 'EUSTX50',
    Bund    => 'Bund',
);

my %reverseInstrumentMap = map { $instrumentMap{$_} => $_ } keys %instrumentMap;

my %timeframeMap = (
    60     => 'M1',
    300    => 'M5',
    3600   => 'H1',
    86400  => 'D1',
    604800 => 'W',
);


sub convertSymbolToOanda {
    my ($symbol) = @_;

    die("Unsupported symbol '$symbol'") if (!exists($instrumentMap{$symbol}));
    return $instrumentMap{$symbol};
}

sub convertTimeframeToOanda {
    my ($timeframe) = @_;

    die("Unsupported timeframe '$timeframe'") if (!exists($timeframeMap{$timeframe}));
    return $timeframeMap{$timeframe};
}



#pod2usage(1) if ( $help || !defined($timeframes_from_txt));

my $cfg = Finance::HostedTrader::Config->new();
my $providerCfg = $cfg->tradingProviders->{oanda};

my $server_url  = $providerCfg->{serverURL};
my $account_id  = $providerCfg->{accountid};
my $token_file  = $providerCfg->{token};
my $token       = read_file($token_file);

my $client = REST::Client->new(
    host    =>  $server_url
);
$client->addHeader("Authorization", "Bearer $token");


sub _handle_oanda_response {
    my $client = shift;

    my $content = $client->responseContent;
    return decode_json($content);
}

sub _map_args_to_oanda {
    my $args = shift;

    my %oanda_arg_map = (
        timeframe   => { name => 'granularity',   map_function => \&convertTimeframeToOanda },
    );

    my %oanda_args = %$args;

    for my $arg (keys %oanda_arg_map) {
        next unless(exists($oanda_args{ $arg }));
        $oanda_args{$oanda_arg_map{$arg}->{name}} = $oanda_arg_map{$arg}->{map_function}->(delete($oanda_args{$arg}));
    }

    return \%oanda_args;
}

sub get_instruments {
    $client->GET("/v3/accounts/$account_id/instruments");
    my $obj = _handle_oanda_response($client);

    return map { $_->{name} } @{$obj->{instruments}};
}

sub get_historical_data {
# See http://developer.oanda.com/rest-live-v20/instrument-ep/
    my %args = @_;

    my $instrument = delete $args{instrument};
    my $oanda_args = _map_args_to_oanda(\%args);

    my $qq = URI::Query->new($oanda_args);

    $client->GET("/v3/instruments/$instrument/candles?" . $qq->stringify);
    my $obj = _handle_oanda_response($client);
    return $obj;
}

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

    $client->GET("/v3/accounts/$account_id/summary");
    my $account_obj = _handle_oanda_response($client);

    $client->GET("/v3/accounts/$account_id/openPositions");
    my $positions = _handle_oanda_response($client);


    my $acc = $account_obj->{account};

    my $NAV = $acc->{NAV};
    my $account_currency = $acc->{currency};
    my %account_risk = (
        nav     => $NAV,
        leverage => sprintf("%.2f",$acc->{positionValue} / $NAV),
        position_value => $acc->{positionValue},
    );

    my $signal_processor = Finance::HostedTrader::ExpressionParser->new();
    my $params = {
        'expression'        => "datetime,previous(atr(14),1)",
        'timeframe'         => "day",
        'item_count'        => 1,
    };

    return \%account_risk;

    foreach my $position (@{ $positions->{positions} }) {
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
        push @{ $account_risk{positions} }, {
            instrument                  => $reverseInstrumentMap{$position->{instrument}},
            daily_volatility            => sprintf("%.4f", $average_daily_volatility),
            daily_volatility_percent    => sprintf("%.6f", $volatility_nav_ratio),
        };
    }
}

my $o = get_account_risk();

#use Data::Dumper;
#print Dumper($o);
use DateTime;
print DateTime->now()->iso8601()."Z,$o->{nav},$o->{position_value},$o->{leverage}\n";
exit;

my $data = get_historical_data(
    instrument  => "EUR_USD",
    timeframe   => "300",
    count       => 50,
);
#print Dumper($data);use Data::Dumper;
print join("\n", map { "$_->{time},$_->{mid}{c}" } @{ $data->{candles} });

__END__
