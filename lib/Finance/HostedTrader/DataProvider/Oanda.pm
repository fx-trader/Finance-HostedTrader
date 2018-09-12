package Finance::HostedTrader::DataProvider::Oanda;

# ABSTRACT: Finance::HostedTrader::DataProvider::Oanda - Download historicaldata from Oanda

=head1 SYNOPSIS

=cut

use Moo;
extends 'Finance::HostedTrader::DataProvider';

use LWP::UserAgent;
use File::Slurp;
use JSON::MaybeXS;
use URI::Query;

sub _build_instrumentMap {
    return {
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
        UKOil  => 'UKOil',
        US30   => 'US30',
        USOil  => 'WTICO_USD',
        CORNUSD   => 'CORN_USD',
        WHEATUSD  => 'WHEAT_USD',
        COPPERUSD => 'COPPER_USD',
        XPTUSD => 'XPT_USD',
        XPDUSD => 'XPD_USD',
    };
}

sub _build_timeframeMap {
    return {
        60     => 'M1',
        300    => 'M5',
        900    => 'M15',
        3600   => 'H1',
        86400  => 'D1',
        604800 => 'W',
    };
}

sub BUILD {
    my ($self, $args) = @_;

    my $providerCfg = $self->cfg->tradingProviders->{oanda};

    $self->{_account_id}    = $providerCfg->{accountid};
    my $token_file  = $providerCfg->{token};
    my $token       = read_file($token_file);

    my $client = LWP::UserAgent->new();
    $client->default_header("Authorization" => "Bearer $token");
    $client->default_header("Content-Type" => "application/json");
    $client->default_header("Accept-Datetime-Format" => "UNIX");

    $self->{_client} = $client;
}


sub _handle_oanda_response {
    my ($self, $response) = @_;

    if (!$response->is_success()) {
        $self->log->logconfess($response->status_line());
    }
    my $content = $response->decoded_content();
    return $self->_decode_oanda_json($content);
}

sub _decode_oanda_json {
    my $self = shift;
    my $oanda_json = shift;

    my $obj;
    eval {
        $obj = decode_json($oanda_json);
        1;
    } or do {
        $self->log->logconfess($oanda_json);
    };
    $self->log->logconfess($obj->{errorMessage}) if ($obj->{errorMessage});
    return $obj;
}



=item C<saveHistoricalDataToFile($filename, $instrument, $tf, $numberOfItems)>

=cut

sub saveHistoricalDataToFile {
    my ($self, $filename, $instrument, $tf, $numberOfItems) = @_;


    $instrument = $self->convertInstrumentTo($instrument);
    $tf = $self->convertTimeframeTo($tf);

    my $oanda_args = {
        granularity => $tf,
        count       => $numberOfItems,
    };

    my $qq = URI::Query->new($oanda_args);

    my $server_url = $self->cfg->tradingProviders->{oanda}->{serverURL};
    open my $fh, '>', $filename or $self->log->logconfess("Cannot open $filename for writting: $!");
    # See http://developer.oanda.com/rest-live-v20/instrument-ep/
    my $response = $self->{_client}->get("${server_url}/v3/instruments/$instrument/candles?" . $qq->stringify);
    my $obj = $self->_handle_oanda_response($response);
    foreach my $candle ( @{ $obj->{candles} } ) {
        my $price = $candle->{mid};
        print $fh $candle->{time}, "\t", $price->{o}, "\t", $price->{h}, "\t", $price->{l}, "\t", $price->{c}, "\n";
    }

    close($fh);
}

=item C<getHistoricalData($instrument, $tf, $numberOfItems)>

See also http://developer.oanda.com/rest-live-v20/instrument-ep/

=cut

sub getHistoricalData {
    my ($self, $instrument, $tf, $numberOfItems) = @_;

    $instrument = $self->convertInstrumentTo($instrument);
    $tf = $self->convertTimeframeTo($tf);

    my $oanda_args = {
        granularity => $tf,
        count       => $numberOfItems,
    };

    my $qq = URI::Query->new($oanda_args);

    my $url = "https://api-fxtrade.oanda.com/v3/instruments/$instrument/candles?" . $qq->stringify;
    my $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");

    return $self->_handle_oanda_response($response);
}

sub streamPriceData {
    my ($self, $instrument, $callback) = @_;

    $instrument = $self->convertInstrumentTo($instrument);

    my $response = $self->{_client}->get(
        "https://stream-fxtrade.oanda.com/v3/accounts/$self->{_account_id}/pricing/stream?instruments=$instrument",
        ':content_cb'    => sub {
            my ($chunk, $response, $protocol) = @_;

            my $obj = $self->_decode_oanda_json($chunk);
            return if ($obj->{type} eq 'HEARTBEAT');

            return $callback->($obj);
        }
    );

    return $response;
}

1;
