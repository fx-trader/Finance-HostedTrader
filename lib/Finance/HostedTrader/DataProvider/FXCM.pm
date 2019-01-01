package Finance::HostedTrader::DataProvider::FXCM;

# ABSTRACT: Finance::HostedTrader::DataProvider::FXCM - Download historicaldata from FXCM

=head1 SYNOPSIS

=cut

use Moo;
extends 'Finance::HostedTrader::DataProvider';

use Finance::FXCM::Simple;

sub _build_instrumentMap {
    return {
        AUDCAD => 'AUD/CAD',
        AUDCHF => 'AUD/CHF',
        AUDJPY => 'AUD/JPY',
        AUDNZD => 'AUD/NZD',
        AUDUSD => 'AUD/USD',
        AUS200 => 'AUS200',
        CADCHF => 'CAD/CHF',
        CADJPY => 'CAD/JPY',
        CHFJPY => 'CHF/JPY',
        CHFNOK => 'CHF/NOK',
        CHFSEK => 'CHF/SEK',
        EURAUD => 'EUR/AUD',
        EURCAD => 'EUR/CAD',
        EURCHF => 'EUR/CHF',
        EURDKK => 'EUR/DKK',
        EURGBP => 'EUR/GBP',
        EURJPY => 'EUR/JPY',
        EURNOK => 'EUR/NOK',
        EURNZD => 'EUR/NZD',
        EURSEK => 'EUR/SEK',
        EURTRY => 'EUR/TRY',
        EURUSD => 'EUR/USD',
        GBPAUD => 'GBP/AUD',
        GBPCAD => 'GBP/CAD',
        GBPCHF => 'GBP/CHF',
        GBPJPY => 'GBP/JPY',
        GBPNZD => 'GBP/NZD',
        GBPSEK => 'GBP/SEK',
        GBPUSD => 'GBP/USD',
        HKDJPY => 'HKD/JPY',
        NOKJPY => 'NOK/JPY',
        NZDCAD => 'NZD/CAD',
        NZDCHF => 'NZD/CHF',
        NZDJPY => 'NZD/JPY',
        NZDUSD => 'NZD/USD',
        SEKJPY => 'SEK/JPY',
        SGDJPY => 'SGD/JPY',
        TRYJPY => 'TRY/JPY',
        USDCAD => 'USD/CAD',
        USDCHF => 'USD/CHF',
        USDDKK => 'USD/DKK',
        USDHKD => 'USD/HKD',
        USDJPY => 'USD/JPY',
        USDMXN => 'USD/MXN',
        USDNOK => 'USD/NOK',
        USDSEK => 'USD/SEK',
        USDSGD => 'USD/SGD',
        USDTRY => 'USD/TRY',
        USDZAR => 'USD/ZAR',
        XAGUSD => 'XAG/USD',
        XAUUSD => 'XAU/USD',
        ZARJPY => 'ZAR/JPY',
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
        XPTUSD => 'XPT/USD',
        XPDUSD => 'CPD/USD',
        USDOLLAR=> 'USDOLLAR',
        NGAS    => 'NGAS',
        EUSTX50 => 'EUSTX50',
        Bund    => 'Bund',
        Wheat   => 'WHEATF',
    };
}

sub _build_timeframeMap {
    return {
        60     => 'm1',
        300    => 'm5',
        3600   => 'H1',
        86400  => 'D1',
        604800 => 'W1',
        18144000 => undef,
    };
}


sub BUILD {
    my ($self, $args) = @_;

    my $providerCfg = $self->cfg->tradingProviders->{fxcm};

    my $fxcm = Finance::FXCM::Simple->new($providerCfg->username, $providerCfg->password, $providerCfg->accountType, $providerCfg->serverURL);

    $self->{_fxcm_client} = $fxcm;
}


=item C<saveHistoricalDataToFile($filename, $instrument, $tf, $numberOfItems)>

=cut

sub saveHistoricalDataToFile {
    my ($self, $filename, $instrument, $tf, $numberOfItems) = @_;


    $instrument = $self->convertInstrumentTo($instrument);
    $tf = $self->convertTimeframeTo($tf);

    $self->{_fxcm_client}->saveHistoricalDataToFile($filename, $instrument, $tf, $numberOfItems);
}

1;
