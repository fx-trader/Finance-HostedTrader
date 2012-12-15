package Finance::HostedTrader::System;

use Moose;
use Config::Any;
use Date::Manip;
use Hash::Merge;
use YAML::Tiny;

use Moose::Util::TypeConstraints;

use Finance::HostedTrader::Config;



# ABSTRACT: Finance::HostedTrader::System - System definition class

=head1 SYNOPSIS

=cut

=attr C<name>

=cut
has 'name' => (
    is     => 'ro',
    isa    => 'Str',
    required=>1,
);

=attr C<symbolUpdateInterval>
=cut
has symbolUpdateInterval => (
    is     => 'ro',
    isa    => 'Int',
    default=> 900,
    required=>1,
);

=attr C<pathToSystems>
=cut
has pathToSystems => (
    is      => 'rw',
    isa     => 'Str',
    default => 'systems',
    required=> 1,
);


=method C<BUILD>


=cut
sub BUILD {
    my $self = shift;

    $self-> _loadSystem();
    $self->{symbols} = $self->_loadSymbols();
    $self->{_symbolsLastUpdated} = 0;
}

=method C<getSymbolsNextUpdate>
=cut
sub getSymbolsNextUpdate {
    my $self = shift;

    my $nextWeekdayUpdate = $self->{_symbolsLastUpdated} + $self->symbolUpdateInterval;

    #TODO what i mean here is, if the market is open, use $self->symbolUpdateInterval
    #if the market is not open, wait until it's open.
    my ($sec, $min, $hr, $day, $month, $year, $weekday) = gmtime($nextWeekdayUpdate);
    if  ($weekday != 0 && $weekday != 6 ) {
        return $nextWeekdayUpdate;
    } else {
        my $nextWeekendUpdate = $self->{_symbolsLastUpdated} + 10800;
        return ($nextWeekendUpdate > $nextWeekdayUpdate ? $nextWeekendUpdate : $nextWeekdayUpdate);
    }

}

=method C<symbols()>

=cut
sub symbols {
    my ($self, $direction) = @_;

    return $self->{symbols}->{$direction};
}

sub _loadSystem {
    my $self = shift;
    my $self_name = $self->name;

    my $file = $self->pathToSystems."/".$self_name.".yml";
    die("Cannot read system file from '$file'") if ( ! -r $file);
    my $tradeable_filter = $self->pathToSystems."/".$self_name.".tradeable.yml";
    my @files = ($file, $tradeable_filter);
    my $system_all = Config::Any->load_files(
        {
            files => \@files,
            use_ext => 1,
            flatten_to_hash => 1,
        }
    );
    my $system = {};

    my $merge = Hash::Merge->new('custom_merge'); #The custom_merge behaviour is defined in Finance::HostedTrader::Config
    foreach my $file (@files) {
        next unless ( $system_all->{$file} );
        my $new_system = $merge->merge($system_all->{$file}, $system);
        $system=$new_system;
    }

    die("failed to load system from $file. $!") unless defined($system_all);
    die("invalid name in symbol file $tradeable_filter") if ($self_name ne $system->{name});

    foreach my $key (keys(%$system)) {
        $self->{$key} = $system->{$key};
    }
    my $filters_signals = $self->{filters}->{signals};
    foreach my $filter_signal (@$filters_signals) {
        $filter_signal->{args}->{period} = int(Delta_Format(ParseDateDelta($filter_signal->{args}->{period}), 0, "%st"));
    }
    foreach my $signal (qw/enter exit add/) {
        if (defined($self->{signals}->{$signal})) {
            my $seconds_delta = int(Delta_Format(ParseDateDelta($self->{signals}->{$signal}->{args}->{period}), 0, "%st"));
            die("Bad signal argument: $self_name\->signals->$signal\->period = $self->{signals}->{$signal}->{args}->{period}") if (!$seconds_delta);
            $self->{signals}->{$signal}->{args}->{period} = $seconds_delta;
        }
    }
}

sub _loadSymbols {
    my $self = shift;
    my $file = $self->_getSymbolFileName;

    my $yaml = YAML::Tiny->new;
    if (-e $file) {
        $yaml = YAML::Tiny->read( $file ) || die("Cannot read symbols from $file. $!");
    } else {
        return { long => [], short => []};
    }
    return { long => [], short => []} if (!defined($yaml->[0]));
    my $self_name = $self->name;
    die("invalid name in symbol file $file") if ($self_name ne $yaml->[0]->{name});

    return $yaml->[0]->{symbols};
}

sub _getSymbolFileName {
    my ($self) = @_;

    return $self->pathToSystems.'/'.$self->name.'.symbols.yml';
}
1;
