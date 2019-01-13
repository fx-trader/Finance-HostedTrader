package Finance::HostedTrader::Provider::Oanda;

# ABSTRACT: Finance::HostedTrader::Provider::Oanda - Download historicaldata from Oanda

=head1 SYNOPSIS

=cut

use Moo;
extends 'Finance::HostedTrader::Provider';

use LWP::UserAgent;
use File::Slurp;
use JSON::MaybeXS;
use URI::Query;

=attr C<accountid>

Account to connect to

=cut

has account_id => (
    is          => 'ro',
    required    => 1,
);

=attr C<token>

File containing an access token to connect with

=cut

has token_file => (
    is          => 'ro',
    required    => 1,
);

=attr C<serverURL>

Oanda server URL. https://api-fxpractice.oanda.com for demo or https://api-fxtrade.oanda.com for real.

See http://developer.oanda.com/rest-live-v20/development-guide/

=cut


has serverURL => (
    is     => 'ro',
    default=> 'https://api-fxtrade.oanda.com',
    required=>1,
);


has datetime_format => (
    is => 'ro',
    isa => sub {
            die("Invalid datetime_format $_[0].  Must be either 'UNIX' or 'RFC3339'")
                unless ($_[0] eq 'UNIX' || $_[0] eq 'RFC3339');
        },
    default => sub { "RFC3339" },
);

sub _build_instrumentMap {
#root@fx-shell:~# perl -MFinance::HostedTrader::Provider::Oanda -e 'my $o=Finance::HostedTrader::Provider::Oanda->new();my @i = sort $o->getInstrumentsFromProvider(); foreach my $a (@i) { print "        $a => '\''$a'\'',\n"};'
#Fix JP225_USD, should be JP225_JPY as it's priced in Yen, not Dollars
    return {
        AU200_AUD => 'AU200_AUD',
        AUD_CAD => 'AUD_CAD',
        AUD_CHF => 'AUD_CHF',
        AUD_HKD => 'AUD_HKD',
        AUD_JPY => 'AUD_JPY',
        AUD_NZD => 'AUD_NZD',
        AUD_SGD => 'AUD_SGD',
        AUD_USD => 'AUD_USD',
        BCO_USD => 'BCO_USD',
        CAD_CHF => 'CAD_CHF',
        CAD_HKD => 'CAD_HKD',
        CAD_JPY => 'CAD_JPY',
        CAD_SGD => 'CAD_SGD',
        CHF_HKD => 'CHF_HKD',
        CHF_JPY => 'CHF_JPY',
        CHF_ZAR => 'CHF_ZAR',
        CN50_USD => 'CN50_USD',
        CORN_USD => 'CORN_USD',
        DE10YB_EUR => 'DE10YB_EUR',
        DE30_EUR => 'DE30_EUR',
        EU50_EUR => 'EU50_EUR',
        EUR_AUD => 'EUR_AUD',
        EUR_CAD => 'EUR_CAD',
        EUR_CHF => 'EUR_CHF',
        EUR_CZK => 'EUR_CZK',
        EUR_DKK => 'EUR_DKK',
        EUR_GBP => 'EUR_GBP',
        EUR_HKD => 'EUR_HKD',
        EUR_HUF => 'EUR_HUF',
        EUR_JPY => 'EUR_JPY',
        EUR_NOK => 'EUR_NOK',
        EUR_NZD => 'EUR_NZD',
        EUR_PLN => 'EUR_PLN',
        EUR_SEK => 'EUR_SEK',
        EUR_SGD => 'EUR_SGD',
        EUR_TRY => 'EUR_TRY',
        EUR_USD => 'EUR_USD',
        EUR_ZAR => 'EUR_ZAR',
        FR40_EUR => 'FR40_EUR',
        GBP_AUD => 'GBP_AUD',
        GBP_CAD => 'GBP_CAD',
        GBP_CHF => 'GBP_CHF',
        GBP_HKD => 'GBP_HKD',
        GBP_JPY => 'GBP_JPY',
        GBP_NZD => 'GBP_NZD',
        GBP_PLN => 'GBP_PLN',
        GBP_SGD => 'GBP_SGD',
        GBP_USD => 'GBP_USD',
        GBP_ZAR => 'GBP_ZAR',
        HK33_HKD => 'HK33_HKD',
        HKD_JPY => 'HKD_JPY',
        IN50_USD => 'IN50_USD',
        JP225_JPY => 'JP225_USD',
        NAS100_USD => 'NAS100_USD',
        NATGAS_USD => 'NATGAS_USD',
        NL25_EUR => 'NL25_EUR',
        NZD_CAD => 'NZD_CAD',
        NZD_CHF => 'NZD_CHF',
        NZD_HKD => 'NZD_HKD',
        NZD_JPY => 'NZD_JPY',
        NZD_SGD => 'NZD_SGD',
        NZD_USD => 'NZD_USD',
        SG30_SGD => 'SG30_SGD',
        SGD_CHF => 'SGD_CHF',
        SGD_HKD => 'SGD_HKD',
        SGD_JPY => 'SGD_JPY',
        SOYBN_USD => 'SOYBN_USD',
        SPX500_USD => 'SPX500_USD',
        SUGAR_USD => 'SUGAR_USD',
        TRY_JPY => 'TRY_JPY',
        TWIX_USD => 'TWIX_USD',
        UK100_GBP => 'UK100_GBP',
        UK10YB_GBP => 'UK10YB_GBP',
        US2000_USD => 'US2000_USD',
        US30_USD => 'US30_USD',
        USB02Y_USD => 'USB02Y_USD',
        USB05Y_USD => 'USB05Y_USD',
        USB10Y_USD => 'USB10Y_USD',
        USB30Y_USD => 'USB30Y_USD',
        USD_CAD => 'USD_CAD',
        USD_CHF => 'USD_CHF',
        USD_CNH => 'USD_CNH',
        USD_CZK => 'USD_CZK',
        USD_DKK => 'USD_DKK',
        USD_HKD => 'USD_HKD',
        USD_HUF => 'USD_HUF',
        USD_INR => 'USD_INR',
        USD_JPY => 'USD_JPY',
        USD_MXN => 'USD_MXN',
        USD_NOK => 'USD_NOK',
        USD_PLN => 'USD_PLN',
        USD_SAR => 'USD_SAR',
        USD_SEK => 'USD_SEK',
        USD_SGD => 'USD_SGD',
        USD_THB => 'USD_THB',
        USD_TRY => 'USD_TRY',
        USD_ZAR => 'USD_ZAR',
        WHEAT_USD => 'WHEAT_USD',
        WTICO_USD => 'WTICO_USD',
        XAG_AUD => 'XAG_AUD',
        XAG_CAD => 'XAG_CAD',
        XAG_CHF => 'XAG_CHF',
        XAG_EUR => 'XAG_EUR',
        XAG_GBP => 'XAG_GBP',
        XAG_HKD => 'XAG_HKD',
        XAG_JPY => 'XAG_JPY',
        XAG_NZD => 'XAG_NZD',
        XAG_SGD => 'XAG_SGD',
        XAG_USD => 'XAG_USD',
        XAU_AUD => 'XAU_AUD',
        XAU_CAD => 'XAU_CAD',
        XAU_CHF => 'XAU_CHF',
        XAU_EUR => 'XAU_EUR',
        XAU_GBP => 'XAU_GBP',
        XAU_HKD => 'XAU_HKD',
        XAU_JPY => 'XAU_JPY',
        XAU_NZD => 'XAU_NZD',
        XAU_SGD => 'XAU_SGD',
        XAU_USD => 'XAU_USD',
        XAU_XAG => 'XAU_XAG',
        XCU_USD => 'XCU_USD',
        XPD_USD => 'XPD_USD',
        XPT_USD => 'XPT_USD',
        ZAR_JPY => 'ZAR_JPY',
    };
}

sub _build_timeframeMap {
    return {
        5      => 'S5',
        10     => 'S10',
        15     => 'S15',
        30     => 'S30',
        60     => 'M1',
        120    => 'M2',
        240    => 'M4',
        300    => 'M5',
        600    => 'M10',
        900    => 'M15',
        1800   => 'M30',
        3600   => 'H1',
        7200   => 'H2',
        10800  => 'H3',
        14400  => 'H4',
        21600  => 'H6',
        28800  => 'H8',
        43200  => 'H12',
        86400  => 'D',
        604800 => 'W',
        18144000 => 'M',
    };
}

sub BUILD {
    my ($self, $args) = @_;

    $self->{_account_id}    = $self->account_id;
    my $token       = read_file($self->token_file);

    my $client = LWP::UserAgent->new();
    $client->default_header("Authorization" => "Bearer $token");
    $client->default_header("Content-Type" => "application/json");
    $client->default_header("Accept-Datetime-Format" => $self->datetime_format);
    if ($ENV{https_proxy}) {
        $ENV{https_proxy} =~ s/^https/connect/;
        $client->proxy('https', $ENV{https_proxy});
    }

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

sub getInstrumentsFromProvider {
    my $self = shift;

    my $url = "https://api-fxtrade.oanda.com/v3/accounts/$self->{_account_id}/instruments";
    my $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");
    my $obj = $self->_handle_oanda_response($response);

    return map { $_->{name} } @{$obj->{instruments}};
}

sub getAccountSummary {
    my $self = shift;

    my $url     = "https://api-fxtrade.oanda.com/v3/accounts/$self->{_account_id}/summary";
    my $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");
    return $self->_handle_oanda_response($response);
}

sub getOpenPositions {
    my $self = shift;

    my $url     = "https://api-fxtrade.oanda.com/v3/accounts/$self->{_account_id}/openPositions";
    my $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");
    return $self->_handle_oanda_response($response);
}

=item C<saveHistoricalDataToFile($filename, $instrument, $tf, $numberOfItems)>

See http://developer.oanda.com/rest-live-v20/instrument-ep/

=cut

sub saveHistoricalDataToFile {
    my ($self, $filename, $instrument, $tf, $numberOfItems) = @_;


    $instrument = $self->convertInstrumentTo($instrument);
    $tf = $self->convertTimeframeTo($tf);

    my $server_url = $self->serverURL;
    my $timeTo = undef;
    open my $fh, '>', $filename or $self->log->logconfess("Cannot open $filename for writting: $!");

    while ($numberOfItems > 0) {

        my $oanda_args = {
            granularity => $tf,
            count       => ($numberOfItems > 5000 ? 5000 : $numberOfItems),
            to          => $timeTo,
        };

        my $qq = URI::Query->new($oanda_args);

        my $response = $self->{_client}->get("${server_url}/v3/instruments/$instrument/candles?" . $qq->stringify);
        my $obj = $self->_handle_oanda_response($response);
        foreach my $candle ( @{ $obj->{candles} } ) {
            my $price = $candle->{mid};
            print $fh $candle->{time}, "\t", $price->{o}, "\t", $price->{h}, "\t", $price->{l}, "\t", $price->{c}, "\n";
        }

        $numberOfItems -= scalar(@{$obj->{candles}});
        if ($numberOfItems > 0) {
            $timeTo = $obj->{candles}->[0]->{time};
            warn "$timeTo\n";
        }
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
