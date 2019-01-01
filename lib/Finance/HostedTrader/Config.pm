package Finance::HostedTrader::Config;

# ABSTRACT: Finance::HostedTrader::Config - Configuration for the Finance::HostedTrader platform

=head1 SYNOPSIS

    use Finance::HostedTrader::Config;
    my $obj = $Finance::HostedTrader::Config->new(); #Builds from system config file (/etc/fxtrader/fx.yml)

    ... OR ...

    my $cfg = Finance::HostedTrader::Config->new( #Builds from specified config file
		'file' => 'cfg1.yml' );

    ... OR ...

    use Finance::HostedTrader::Config::DB;
    use Finance::HostedTrader::Config::Symbols;
    use Finance::HostedTrader::Config::Timeframes;

    my $db = Finance::HostedTrader::Config::DB->new(
		'dbhost' => 'dbhost',
		'dbname' => 'dbname',
		'dbuser' => 'dbuser',
		'dbpasswd'=> 'dbpasswd',
	);

    my $timeframes = Finance::HostedTrader::Config::Timeframes->new(
		'natural' => [ qw (300 60) ], #Make sure timeframes are unordered to test if the module returns them ordered
	);

    my $symbols = Finance::HostedTrader::Config::Symbols->new(
		'natural' => [ qw (AUDUSD USDJPY) ],
	);

    $obj = Finance::HostedTrader::Config->new( 'db' => $db, 'symbols' => $symbols, 'timeframes' => $timeframes );

=cut

use Config::Any;
use Moo;
use Carp;

use Finance::HostedTrader::Config::DB;
use Finance::HostedTrader::Config::Symbols;
use Finance::HostedTrader::Config::Timeframes;
use Finance::HostedTrader::Config::Provider::Factory;


=attr C<db>
<L><Finance::HostedTrader::Config::DB> object containing db config information
=cut
has db => (
    is       => 'ro',
    isa      => sub { die("invalid type") unless ($_[0]->isa("Finance::HostedTrader::Config::DB")) },
    required => 1,
);

=attr C<symbols>
<L><Finance::HostedTrader::Config::Symbols> object containing available symbols
=cut
has symbols => (
    is       => 'ro',
    isa      => sub { die("invalid type") unless ($_[0]->isa("Finance::HostedTrader::Config::Symbols")) },
    required => 1,
);

=attr C<timeframes>
<L><Finance::HostedTrader::Config::Timeframes> object containing available timeframes
=cut
has timeframes => (
    is       => 'ro',
    isa      => sub { die("invalid type") unless ($_[0]->isa("Finance::HostedTrader::Config::Timeframes")) },
    required => 1,
);

=attr C<providers>
<L><Finance::HostedTrader::Config::Provider> hasref of available providers configuration
=cut
has providers => (
    is       => 'ro',
    required => 0,
);

=method C<BUILDARGS>

See SYNOPSIS for available options.

=cut
around BUILDARGS => sub {
    my $orig = shift;
    my $class = shift;
    my $cfgfile   = "/etc/fxtrader/fx.yml";

    if ( scalar(@_) > 1 ) {
	if ( $_[0] eq 'file' ) {
		$cfgfile = $_[1];
	} else {
# Direct constructor without reading any configuration file 
         return $class->$orig(@_);
	}
    }



    my $cfg_any = Config::Any->load_files(
        { files => [ $cfgfile ], use_ext => 1, flatten_to_hash => 1 } );

    confess("No config file found at $cfgfile.\n") if (!exists($cfg_any->{$cfgfile}));

    my $cfg = $cfg_any->{$cfgfile};

    my $class_args = {
        'db' => Finance::HostedTrader::Config::DB->new($cfg->{db}),
        'symbols' => Finance::HostedTrader::Config::Symbols->new($cfg->{symbols}),
        'timeframes' => Finance::HostedTrader::Config::Timeframes->new($cfg->{timeframes}),
        'providers' => {
            map { $_ => Finance::HostedTrader::Config::Provider::Factory->new()->create_instance($_, $cfg->{providers}->{$_}) }  keys %{$cfg->{providers}}
        },
    };

    return $class->$orig($class_args);
};

__PACKAGE__->meta->make_immutable;
1;

=head1 SEE ALSO

L<Finance::HostedTrader::Datasource>,L<Finance::HostedTrader::Config>,L<Finance::HostedTrader::Config::DB>,L<Finance::HostedTrader::Config::Timeframes>,L<Finance::HostedTrader::Symbols>

=cut
