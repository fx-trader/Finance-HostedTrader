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

=attr C<endpoint_hosts>

Oanda server URL. https://api-fxpractice.oanda.com for demo or https://api-fxtrade.oanda.com for real.

See http://developer.oanda.com/rest-live-v20/development-guide/

=cut


has endpoint_hosts => (
    is      => 'ro',
    isa     => sub {
        my $endpoint_hosts = shift;
        die("Invalid endpoint_hosts: must be a hash with keys 'rest' and 'stream'.")
            unless ($endpoint_hosts && ref($endpoint_hosts) eq 'HASH' && $endpoint_hosts->{rest} && $endpoint_hosts->{stream});
    },
    required=>1,
);


has datetime_format => (
    is => 'rw',
    isa => sub {
            die("Invalid datetime_format $_[0].  Must be either 'UNIX' or 'RFC3339'")
                unless ($_[0] eq 'UNIX' || $_[0] eq 'RFC3339');
        },
    default => sub { "RFC3339" },
    trigger => sub {
        my ($self, $value) = @_;
        $self->{_client}->default_header("Accept-Datetime-Format" => $value);
    },
);

sub _build_instrumentMap {
#root@fx-shell:~# perl -MFinance::HostedTrader::Config -e 'my $o=Finance::HostedTrader::Config->new()->provider('oanda_demo');my @i = sort $o->getInstrumentsFromProvider(); foreach my $a (@i) { print "        $a => '\''$a'\'',\n"};'
#Fix JP225_USD, should be JP225_JPY as it's priced in Yen, not Dollars
    return {
        AU200_AUD => 'AU200_AUD',
        AUD_CHF => 'AUD_CHF',
        AUD_HKD => 'AUD_HKD',
        AUD_JPY => 'AUD_JPY',
        AUD_NZD => 'AUD_NZD',
        AUD_USD => 'AUD_USD',
        BCO_USD => 'BCO_USD',
        CHF_JPY => 'CHF_JPY',
        CN50_USD => 'CN50_USD',
        CORN_USD => 'CORN_USD',
        DE10YB_EUR => 'DE10YB_EUR',
        DE30_EUR => 'DE30_EUR',
        EU50_EUR => 'EU50_EUR',
        EUR_AUD => 'EUR_AUD',
        EUR_CAD => 'EUR_CAD',
        EUR_CHF => 'EUR_CHF',
        EUR_GBP => 'EUR_GBP',
        EUR_HKD => 'EUR_HKD',
        EUR_JPY => 'EUR_JPY',
        EUR_NZD => 'EUR_NZD',
        EUR_USD => 'EUR_USD',
        FR40_EUR => 'FR40_EUR',
        GBP_CHF => 'GBP_CHF',
        GBP_JPY => 'GBP_JPY',
        GBP_NZD => 'GBP_NZD',
        GBP_USD => 'GBP_USD',
        HK33_HKD => 'HK33_HKD',
        IN50_USD => 'IN50_USD',
        JP225_JPY => 'JP225_USD',
        NAS100_USD => 'NAS100_USD',
        NATGAS_USD => 'NATGAS_USD',
        NL25_EUR => 'NL25_EUR',
        NZD_CHF => 'NZD_CHF',
        NZD_HKD => 'NZD_HKD',
        NZD_JPY => 'NZD_JPY',
        NZD_USD => 'NZD_USD',
        SG30_SGD => 'SG30_SGD',
        SOYBN_USD => 'SOYBN_USD',
        SPX500_USD => 'SPX500_USD',
        SUGAR_USD => 'SUGAR_USD',
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
        XAG_EUR => 'XAG_EUR',
        XAG_GBP => 'XAG_GBP',
        XAG_USD => 'XAG_USD',
        XAU_EUR => 'XAU_EUR',
        XAU_USD => 'XAU_USD',
        XAU_XAG => 'XAU_XAG',
        XCU_USD => 'XCU_USD',
        XPD_USD => 'XPD_USD',
        XPT_USD => 'XPT_USD',
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

    $self->{_token} = read_file($self->token_file);

    my $client = LWP::UserAgent->new(
        keep_alive => 100, 
        ssl_opts => {
            SSL_cipher_list => 'DEFAULT:!DH' # see https://stackoverflow.com/questions/36417224/openssl-dh-key-too-small-error
	});
    $client->default_header("Authorization" => "Bearer $self->{_token}");
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

    my $content = $response->decoded_content();
    if (!$response->is_success()) {
        $self->log->logconfess($response->status_line(), "\n$content");
    }
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

    my $url = "https://api-fxtrade.oanda.com/v3/accounts/${\$self->account_id}/instruments";
    my $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");
    my $obj = $self->_handle_oanda_response($response);

    return { map { $_->{name}, $_ } @{$obj->{instruments}} };
}

sub getAccountSummary {
    my $self = shift;

    my $url     = "https://api-fxtrade.oanda.com/v3/accounts/${\$self->account_id}/summary";
    my $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");
    return $self->_handle_oanda_response($response);
}

sub getOpenPositions {
    my $self = shift;

    my $url     = "https://api-fxtrade.oanda.com/v3/accounts/${\$self->account_id}/openPositions";
    my $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");
    return $self->_handle_oanda_response($response);
}

sub getOpenTrades {
    my $self = shift;

    my $url     = "https://api-fxtrade.oanda.com/v3/accounts/${\$self->account_id}/openTrades";
    my $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");
    return $self->_handle_oanda_response($response)->{trades};
}

=item C<saveHistoricalDataToFile($filename, $instrument, $tf, $numberOfItems)>

See http://developer.oanda.com/rest-live-v20/instrument-ep/

=cut

sub saveHistoricalDataToFile {
    my ($self, $filename, $instrument, $tf, $numberOfItems) = @_;


    $instrument = $self->convertInstrumentTo($instrument);
    $tf = $self->convertTimeframeTo($tf);

    my $server_url = $self->endpoint_hosts->{rest};
    my $timeTo = undef;
    open my $fh, '>', $filename or $self->log->logconfess("Cannot open $filename for writting: $!");

    while ($numberOfItems > 0) {

        my $oanda_args = {
            granularity => $tf,
            count       => ($numberOfItems > 5000 ? 5000 : $numberOfItems),
            to          => $timeTo,
            price       => 'BAM',
        };

        my $qq = URI::Query->new($oanda_args);

        my $response = $self->{_client}->get("https://${server_url}/v3/instruments/$instrument/candles?" . $qq->stringify);
        my $obj = $self->_handle_oanda_response($response);
        foreach my $candle ( @{ $obj->{candles} } ) {
            next unless ($candle->{complete});
            my $price_bid = $candle->{bid};
            my $price_ask = $candle->{ask};
            my $price_mid = $candle->{mid};
            print $fh   $candle->{time}, "\t",
                        $price_ask->{o}, "\t",
                        $price_ask->{h}, "\t",
                        $price_ask->{l}, "\t",
                        $price_ask->{c}, "\t",
                        $price_bid->{o}, "\t",
                        $price_bid->{h}, "\t",
                        $price_bid->{l}, "\t",
                        $price_bid->{c}, "\t",
                        $price_mid->{o}, "\t",
                        $price_mid->{h}, "\t",
                        $price_mid->{l}, "\t",
                        $price_mid->{c}, "\t",
                        $candle->{volume}, "\n";
        }

        $numberOfItems -= scalar(@{$obj->{candles}});
        if ($numberOfItems > 0) {
            $timeTo = $obj->{candles}->[0]->{time};
            last if(!$timeTo);
            warn "$timeTo\n";
        }
    }

    close($fh);
}

=item C<getHistoricalData($instrument, $tf, $numberOfItems)>

See also http://developer.oanda.com/rest-live-v20/instrument-ep/

=cut

sub getHistoricalData {
    my ($self, $instrument, $tf, $numberOfItems, $from) = @_;

    $instrument = $self->convertInstrumentTo($instrument);
    $tf = $self->convertTimeframeTo($tf);

    my $oanda_args = {
        granularity => $tf,
        count       => $numberOfItems,
        price       => 'BAM',
    };

    if (defined($from)) {
        $oanda_args->{from} = $from;
        $oanda_args->{includeFirst} = 'false';
    }

    my $qq = URI::Query->new($oanda_args);

    return $self->_fetch_obj('rest', "/instruments/$instrument/candles?" . $qq->stringify);
}

sub streamPriceData {
    my ($self, $instruments, $callback) = @_;

    my $instrument_names = join(',', map { $self->convertInstrumentTo($_) } @$instruments);

    my $cache = '';

    my $response = $self->{_client}->get(
        "https://stream-fxtrade.oanda.com/v3/accounts/${\$self->account_id}/pricing/stream?instruments=$instrument_names",
        ':content_cb'    => sub {
            my ($chunk, $response, $protocol) = @_;

            local $/ = "\n";
            my $isFinal = chomp($chunk);

            $cache .= $chunk;
            if (!$isFinal) {
                return;
            }

            my @records = split("\n", $cache);
            $cache = '';

            foreach my $record (@records) {
                my $obj = $self->_decode_oanda_json($record);
                return if ($obj->{type} eq 'HEARTBEAT');

                $obj->{instrument} = $self->convertInstrumentFrom( $obj->{instrument} );

                $callback->($obj);
            }
        }
    );

    return $response;
}

sub _fetch_obj {
    my ($self, $host_type, $url_path, $parameters, $method, $body) = @_;

    my $host = $self->{endpoint_hosts}{$host_type};
    my $url = "https://${host}/v3${url_path}";
    my $response;

    if (!defined($method) || $method eq 'get') {
        $response = $self->{_client}->get($url) or $self->log->logconfess("Unable to get $url:\n$!");
    } elsif ( $method eq 'post' ) {

        my $encoded_json;

        eval {
            $encoded_json = encode_json($body);
            1;
        } or do {
            $self->log->logconfess("failed to encode json");
        };
        $self->log->debug($url);
        $self->log->debug($encoded_json);
        $response = $self->{_client}->post($url, 'Content' => $encoded_json) or $self->log->logconfess("Unable to post to $url:\nContent: $encoded_json\n$!");
    } else {
        $self->log->logconfess("unable to handle http method: $method");
    }
    my $obj = $self->_handle_oanda_response($response);

    return $obj;
}

sub getBid {
    my ($self, $instrument) = @_;

    $instrument = $self->convertInstrumentTo($instrument);
    my $obj = $self->_fetch_obj('rest', "/accounts/${\$self->account_id}/pricing?instruments=$instrument");

    return $obj->{prices}[0]{bids}[0]{price};
}

sub getAsk {
    my ($self, $instrument) = @_;

    $instrument = $self->convertInstrumentTo($instrument);
    my $obj = $self->_fetch_obj('rest', "/accounts/${\$self->account_id}/pricing?instruments=$instrument");

    return $obj->{prices}[0]{asks}[0]{price};
}

sub getOpenTradesForInstrument {
    my ($self, $instrument) = @_;

    $instrument = $self->convertInstrumentTo($instrument);
    my $obj = $self->_fetch_obj('rest', "/accounts/${\$self->account_id}/openTrades");

    my @instrument_trades = grep {$_->{instrument} eq $instrument} @{ $obj->{trades} };

    return \@instrument_trades;
}

sub openMarket {
    my ($self, $instrument, $quantity) = @_;

    $instrument = $self->convertInstrumentTo($instrument);

    my $priceBound;

    my $order = {
        type        => "MARKET",
        instrument  => $instrument,
        units       => "$quantity",
    };
    my $obj = $self->_fetch_obj('rest', "/accounts/${\$self->account_id}/orders", undef, 'post' , { order => $order });
    return 1;
}

sub getBaseUnitSize {

    return 1;
}

1;
