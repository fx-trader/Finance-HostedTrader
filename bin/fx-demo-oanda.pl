#!/usr/bin/perl

# ABSTRACT: Demo oanda v20 api
# PODNAME: fx-demo-oanda.pl


use strict;
use warnings;
$|=1;

use Finance::HostedTrader::Config;
use REST::Client;
use File::Slurp;

my %symbolMap = (
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
    USOil  => 'USOil',
    Copper => 'Copper',
    XPTUSD => 'XPT_USD',
    XPDUSD => 'CPD_USD',
    USDOLLAR=> 'USDOLLAR',
    NGAS    => 'NGAS',
    EUSTX50 => 'EUSTX50',
    Bund    => 'Bund',
);

my %timeframeMap = (
    60     => 'm1',
    300    => 'm5',
    3600   => 'H1',
    86400  => 'D1',
    604800 => 'W1',
);


sub convertSymbolToOanda {
    my ($symbol) = @_;

    die("Unsupported symbol '$symbol'") if (!exists($symbolMap{$symbol}));
    return $symbolMap{$symbol};
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


$client->GET("/v3/accounts");
my $content = $client->responseContent;
print Dumper($content);use Data::Dumper;

__END__
