#!/usr/bin/perl
# ABSTRACT: Outputs the configuration that applies if when a Finance::HostedTrader script is run from the current working directory, including merging of multiple config files.
# PODNAME: fx-show-config.pl

=head1 SYNOPSIS

    fx-show-config.pl [configsetting]

=head1 DESCRIPTION

    Dumps configuration data that applies to the current instance of fxtrader.  Per-directory config files can exist.

=head2 OPTIONS

=over 12

=item C<configsetting>

Optionally output only one item of configuration. Eg:

fx-show-config.pl db::dbuser

This option only works for if the value of "configsetting" is a scalar ( as opposed to an hash/list ).

=back

=head1 SEE ALSO

L<Finance::HostedTrader::Config>

=cut

use strict;
use warnings;

use Finance::HostedTrader::Config;
use Data::Dumper;

my $cfg = Finance::HostedTrader::Config->new();

if (@ARGV) {
    my @values;
    foreach my $key (@ARGV) {
        my @path = split('::', $key);
        my $ptr = $cfg;
        foreach (@path) {
            $ptr = $ptr->{$_};
        }
        push @values, $ptr;
    }
    print join(" ", @values);
} else {
    print Dumper(\$cfg);
}
