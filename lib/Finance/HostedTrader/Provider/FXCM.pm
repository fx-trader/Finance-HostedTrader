package Finance::HostedTrader::Provider::FXCM;

# ABSTRACT: Finance::HostedTrader::Provider::FXCM - Download historicaldata from FXCM

=head1 SYNOPSIS

=cut

use Moo;
extends 'Finance::HostedTrader::Provider';

use Finance::FXCM::Simple;

=attr C<username>

Username to connect to the trading provider

=cut

has username => (
    is     => 'ro',
    required=>1,
);

=attr C<password>

Password to connect to the trading provider

=cut


has password => (
    is     => 'ro',
    required=>1,
);

=attr C<accountType>

FXCM account type. Either 'Demo' or 'Real'.

=cut


has accountType => (
    is     => 'ro',
    required=>1,
);

=attr C<serverURL>

ForexConnect server URL. Tipically http://www.fxcorporate.com/Hosts.jsp

=cut


has serverURL => (
    is     => 'ro',
    default=> 'http://www.fxcorporate.com/Hosts.jsp',
    required=>1,
);



has 'fxcm_client' => (
    is => 'lazy',

);

sub _build_fxcm_client {
    my $self = shift;

    return Finance::FXCM::Simple->new($self->username, $self->password, $self->accountType, $self->serverURL);
}

sub _build_instrumentMap {
    return {
        AU200_AUD => 'AUS200',
        AUD_CAD => 'AUD/CAD',
        AUD_CHF => 'AUD/CHF',
        AUD_JPY => 'AUD/JPY',
        AUD_NZD => 'AUD/NZD',
        AUD_USD => 'AUD/USD',
        CAD_CHF => 'CAD/CHF',
        CAD_JPY => 'CAD/JPY',
        CHF_JPY => 'CHF/JPY',
        CHF_NOK => 'CHF/NOK',
        CHF_SEK => 'CHF/SEK',
        EUR_AUD => 'EUR/AUD',
        EUR_CAD => 'EUR/CAD',
        EUR_CHF => 'EUR/CHF',
        EUR_DKK => 'EUR/DKK',
        EUR_GBP => 'EUR/GBP',
        EUR_JPY => 'EUR/JPY',
        EUR_NOK => 'EUR/NOK',
        EUR_NZD => 'EUR/NZD',
        EUR_SEK => 'EUR/SEK',
        EUR_TRY => 'EUR/TRY',
        EUR_USD => 'EUR/USD',
        GBP_AUD => 'GBP/AUD',
        GBP_CAD => 'GBP/CAD',
        GBP_CHF => 'GBP/CHF',
        GBP_JPY => 'GBP/JPY',
        GBP_NZD => 'GBP/NZD',
        GBP_SEK => 'GBP/SEK',
        GBP_USD => 'GBP/USD',
        HKD_JPY => 'HKD/JPY',
        NOK_JPY => 'NOK/JPY',
        NZD_CAD => 'NZD/CAD',
        NZD_CHF => 'NZD/CHF',
        NZD_JPY => 'NZD/JPY',
        NZD_USD => 'NZD/USD',
        SEK_JPY => 'SEK/JPY',
        SGD_JPY => 'SGD/JPY',
        TRY_JPY => 'TRY/JPY',
        USD_CAD => 'USD/CAD',
        USD_CHF => 'USD/CHF',
        USD_DKK => 'USD/DKK',
        USD_HKD => 'USD/HKD',
        USD_JPY => 'USD/JPY',
        USD_MXN => 'USD/MXN',
        USD_NOK => 'USD/NOK',
        USD_SEK => 'USD/SEK',
        USD_SGD => 'USD/SGD',
        USD_TRY => 'USD/TRY',
        USD_ZAR => 'USD/ZAR',
        XAG_USD => 'XAG/USD',
        XAU_USD => 'XAU/USD',
        ZAR_JPY => 'ZAR/JPY',
        ES35_EUR  => 'ESP35',
        FR40_EUR  => 'FRA40',
        DE30_EUR  => 'GER30',
        HK33_HKD  => 'HKG33',
        IT40_USD  => 'ITA40',
        JP225_JPY => 'JPN225',
        NAS100_USD => 'NAS100',
        SPX500_USD => 'SPX500',
        UK100_GBP  => 'UK100',
        BCO_USD  => 'UKOil',
        US30_USD   => 'US30',
        WTICO_USD  => 'USOil',
        XCU_USD => 'Copper',
        XPT_USD => 'XPT/USD',
        XPD_USD => 'CPD/USD',
        USDOLLAR_USD=> 'USDOLLAR',
        NATGAS_USD    => 'NGAS',
        EU50_EUR => 'EUSTX50',
        DE10YB_EUR   => 'Bund',
        WHEAT_USD   => 'WHEATF',
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

=item C<saveHistoricalDataToFile($filename, $instrument, $tf, $numberOfItems)>

=cut

sub saveHistoricalDataToFile {
    my ($self, $filename, $instrument, $tf, $numberOfItems) = @_;


    $instrument = $self->convertInstrumentTo($instrument);
    $tf = $self->convertTimeframeTo($tf);

    $self->fxcm_client->saveHistoricalDataToFile($filename, $instrument, $tf, $numberOfItems);
}

1;
