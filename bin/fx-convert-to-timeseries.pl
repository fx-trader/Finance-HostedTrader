#!/usr/bin/perl

# PODNAME: fx-convert-to-timeseries.pl
# ABSTRACT: Convert output of fx-trend.pl to a chartable format

=head1 SYNOPSIS

fx-trend.pl --average=13 --numItems=20 --separator=, | fx-convert-to-timeseries.pl > out.csv

# Then in gnuplot
set grid
set datafile separator ','
set key outside

set yrange[-3:3]
set timefmt '%Y-%m-%d'
set xdata time
set xrange ['2015-02-01':'2015-07-01']

#set terminal png size 1024,768 enhanced font "Helvetica,10"
#set output 'output.png'
plot 'out.csv' using 1:2 title 'AUD' with lines, \
     'out.csv' using 1:3 title 'AUS200' with lines \
     etc...

=cut

use strict;
use warnings;

my %out;
while (<STDIN>) {
    chomp();
    my ($asset, $date, $value) = split(/,/);
    $out{$date}{$asset} = $value;
}
my %unique = map { map { $_ => 1} keys(%{$out{$_}})  } keys(%out);
my @symbols = sort(keys(%unique));
print "Time," , join(",", @symbols), "\n";

my @sorted_dates = sort(keys(%out));

foreach my $date (@sorted_dates) {
    print $date;
    foreach my $symbol (@symbols) {
        my $value = (defined($out{$date}{$symbol}) ? $out{$date}{$symbol} : '');
        print ",", $value;
    }
    print "\n";
}
