package Finance::HostedTrader::ExpressionParser;

# ABSTRACT: Finance::HostedTrader::ExpressionParser - Utility object to calculate indicators/signals based on complex expressions
#Maybe one day convert this to lex/bison
#http://www.scribd.com/doc/8669780/Lex-yacc-Tutoriala

use strict;
use warnings;

use Date::Manip;
use Statistics::Descriptive;
use Log::Log4perl qw(:easy);
use List::Util;
use Finance::HostedTrader::Datasource;
use Finance::HostedTrader::Provider;

# See http://search.cpan.org/~jtbraun/Parse-RecDescent-1.967013/lib/Parse/RecDescent.pm#Precompiling_parsers
# For details of how to generate Grammar.pm.
# In a nutshell, it needs to be generated using the same runtime version of Parse::RecDescent, and can be generated by running:
# perl -MParse::RecDescent - /src/Finance-HostedTrader/lib/Finance/HostedTrader/grammar Finance::HostedTrader::ExpressionParser::Grammar
use Finance::HostedTrader::ExpressionParser::Grammar;

my ( %INDICATORS, @VALUES );
my ( @INDICATOR_TIMEFRAMES, %DATETIMES );

sub SetIndicatorTimeframe {
    my ($key, $tf) = @_;

    push @INDICATOR_TIMEFRAMES, $tf;
}

sub GetIndicatorTimeframe {
    my $expression = shift;
    my $expression_win = shift;

    my $tf = pop(@INDICATOR_TIMEFRAMES) // '';
    if ($tf) {
        $DATETIMES{$tf} = 1;
        $expression_win =~ s/TIMEFRAME/$tf/g;
        return $expression_win;
    } else {
        return $expression;
    }
}

sub getID {
    my $type = shift;
    my @rv = ();
    my $key = scalar(@VALUES);

    push @VALUES, { type => $type, items => [] };

    while ( defined(my $item = shift) ) {
        $INDICATORS{$item} = scalar( keys %INDICATORS )
          unless exists $INDICATORS{$item};
        push @{ $VALUES[$key]->{items} }, $item;
    }
    return $key;
}

#$::RD_TRACE=1;
$::RD_HINT   = 1;
$::RD_WARN   = 1;
$::RD_ERRORS = 1;

sub new {
    my ( $class, $ds ) = @_;

# Sample function calls
# macddiff( dataset, shortperiodema, longperiodema, signalema), macddiff(12,26,9)

    my $parser    = Finance::HostedTrader::ExpressionParser::Grammar->new();

    if (!Log::Log4perl->initialized()) {
        if ( -r "/etc/fxtrader/fxtrader.log.conf" ) {
            Log::Log4perl->init("/etc/fxtrader/fxtrader.log.conf");
        }
    }

    my $self = {
        '_parser' => $parser,
        '_ds'       => ( $ds ? $ds : Finance::HostedTrader::Datasource->new() ),
        '_cache'    => {}, # caches parsing of expressions
        '_logger'   => Log::Log4perl::get_logger(),
    };

    return bless( $self, $class );
}

=method C<getDescriptiveStatisticsData>

    Returns descriptive statistic about returns.
    See https://miltonfmr.com/applied-statistics-futures-markets/

=cut

sub getDescriptiveStatisticsData {
    my ($self, $args) = @_;

    my @good_args = qw(provider timeframe instrument instrument symbol max_loaded_items start_period end_period item_count expression percentiles weekdays);
    foreach my $key (keys %$args) {
        $self->{_logger}->logconfess("invalid arg in getStatisticsData: $key") unless grep { /$key/ } @good_args;
    }

    my %stat_args = %{ $args };
    my $percentiles = delete $stat_args{percentiles} // '75,80,85,90,95,99';
    my $expression = delete $stat_args{expression} // '(close-open)/open';
    $stat_args{expression} = "datetime,$expression";

    my $data    = $self->getIndicatorData( \%stat_args );
    my $stat    = Statistics::Descriptive::Full->new();
    my @period_returns  = map {  $_->[1] } @{ $data->{data} };
    delete $data->{data};
    $stat->add_data( @period_returns );

    $data->{stats}  = {
            count               => $stat->count,
            mean                => $stat->mean,
            sum                 => $stat->sum,
            variance            => $stat->variance,
            standard_deviation  => $stat->standard_deviation,
            min                 => $stat->min,
            max                 => $stat->max,
            range               => $stat->max - $stat->min,
            skewness            => $stat->skewness,
            kurtosis            => $stat->kurtosis,
            median              => $stat->median,
        };

    #my @bins = qw/-0.03 -0.025 -0.02 -0.015 -0.01 -0.005 0 0.005 0.01 0.015 0.02 0.025 0.3/;
    #$data->{frequency_distributions} = $stat->frequency_distribution_ref( \@bins );

    #my %cumulative_distributions;
    #my $cumulative_total = 0;
    #foreach my $item ( sort { $a <=> $b } keys %{ $data->{frequency_distributions } } ) {
    #    $cumulative_total += $data->{frequency_distributions}{$item};
    #    $cumulative_distributions{$item}  = $cumulative_total;
    #}
    #$data->{cumulative_frequency_distributions} = \%cumulative_distributions;
    $data->{percentiles} =  { map { $_ => scalar($stat->percentile($_)) } split(/,/, $percentiles) };

    $data->{average_returns}{overall}   = $data->{stats}{mean};
    my $stat_negative_returns = Statistics::Descriptive::Full->new();
    $stat_negative_returns->add_data( grep { $_ < 0 } @period_returns );
    my $stat_positive_returns = Statistics::Descriptive::Full->new();
    $stat_positive_returns->add_data( grep { $_ > 0 } @period_returns );
    $data->{average_returns}{positive}  = $stat_positive_returns->mean;
    $data->{average_returns}{negative}  = $stat_negative_returns->mean;

    return $data;
}

=method C<getIndicatorData>

args

timeframe
expression
instrument
max_loaded_items
end_period
item_count
weekdays

=cut

sub getIndicatorData {
    my ( $self, $args ) = @_;

    my $sql = $self->_getIndicatorSql(%$args);
    $self->{_logger}->debug($sql);

    my $dbh = $self->{_ds}->dbh;
    my $data = $dbh->selectall_arrayref($sql) or $self->{_logger}->logconfess($DBI::errstr);

    return { data => $data, sql => $sql } if ($args->{sqldebug});
    return { data => $data };
}

=method C<getSignalData>
See L</getIndicatorData> for list of arguments.
=cut
sub getSignalData {
    my ( $self, $args ) = @_;

    my $sql = $self->_getSignalSql($args);

    $self->{_logger}->debug($sql);

    my $dbh = $self->{_ds}->dbh;
    my $data;
    $data = $dbh->selectcol_arrayref($sql) || $self->{_logger}->logconfess( $DBI::errstr . $sql );

    return { data => $data, sql => $sql } if ($args->{sqldebug});
    return { data => $data, };
}

=method C<getSystemData>
=cut
sub getSystemData {
    my ( $self, $a ) = @_;

    my %args = %{ $a };

    $args{expr} = delete $args{enter};
    my $exitSignal = delete $args{exit};
    $args{fields} = "'ENTRY' AS Action, datetime, close";

    #TODO, limit nbitems not done here
    my $sql_entry = $self->_getSignalSql(\%args);
    $args{expr} = $exitSignal;
    $args{fields} = "'EXIT' AS Action, datetime, close";
    my $sql_exit  = $self->_getSignalSql(\%args);


    my $sql = $sql_entry . ' UNION ALL ' . $sql_exit . ' ORDER BY datetime';
    $self->{_logger}->debug($sql);

    my $dbh = $self->{_ds}->dbh;
    my $data = $dbh->selectall_arrayref($sql) or $self->{_logger}->logconfess( $DBI::errstr . $sql );
    return $data;
}

sub log_obsolete_argument_names {
    use Devel::StackTrace;
    my ($self, $obsolete_arg_names, $args) = @_;

    my $l = $self->{_logger};
    my $trace = Devel::StackTrace->new();

    foreach my $arg_name (@$obsolete_arg_names) {

        if ( exists ($args->{$arg_name}) ) {
            $l->warn("OBSOLETE ARGUMENT USED: $arg_name");
            $l->warn($trace->as_string);
        }

    }
}

sub _getIndicatorSql {
    my ($self, %args) = @_;
    my ( $result );

    my @obsolete_arg_names  = qw(tf fields maxLoadedItems endPeriod numItems symbol inner_sql_filter);
    $self->log_obsolete_argument_names(\@obsolete_arg_names, \%args);
    my @good_args           = qw(provider timeframe expression instrument max_loaded_items start_period end_period item_count weekdays);

    foreach my $key (keys %args) {
        $self->{_logger}->logconfess("invalid arg in getIndicatorData: $key") unless grep { /$key/ } @good_args, @obsolete_arg_names;
    }

    my $tf_name = $args{timeframe} || $args{tf} || 'min';
    my $tf = $self->{_ds}->cfg->timeframes->getTimeframeID($tf_name);
    $self->{_logger}->logconfess( "Could not understand timeframe " . ( $tf_name ) ) if (!$tf);
    my $maxLoadedItems = $args{max_loaded_items} || $args{maxLoadedItems} || 10_000_000_000;;
    my $displayStartDate   = $args{start_period} || $args{start_period} || '0001-01-01';
    my $displayEndDate   = $args{end_period} || $args{end_period} || '9999-12-31';
    my $expr      = $args{expression} || $args{fields}          || $self->{_logger}->logconfess("No indicator expression set");
    $expr = lc($expr);
    my $instrument= $args{instrument} || $args{symbol}          || $self->{_logger}->logconfess("No instrument set for indicator");
    my $itemCount = $args{item_count} || $args{numItems} || 10_000_000;
    my $provider  = $args{provider};

    my $data_provider = $self->{_ds}->cfg->provider($provider);

    #TODO: Refactor the parser bit so that it can be called independently. This will be usefull to validate expressions before running them.
    $result     = $self->{_parser}->start_indicator($expr);

    #TODO: Need a more meaningfull error message describing what's wrong with the given expression
    $self->{_logger}->logdie("Syntax error in indicator \n\n$expr\n")
        unless ( defined($result) );

    my $WHERE_FILTER = "WHERE datetime >= '$displayStartDate' AND datetime <= '$displayEndDate'";
#    $WHERE_FILTER .= ' AND dayofweek(datetime) <> 1' if ( $tf != 604800 );

    my $tableName = $data_provider->getTableName($instrument, $tf);

    my $datetime_labels = join(', ', map {"datetime_${_}"} keys %DATETIMES);
    use Finance::HostedTrader::Synthetics;
    my $datetime_expressions = join(', ', map { Finance::HostedTrader::Synthetics::getDateFormat($_) . " AS datetime_${_}" } keys %DATETIMES);
    $datetime_expressions .= ',' if ($datetime_expressions);

    my $sql = "
WITH T AS (
  SELECT datetime, mid_open AS open, mid_high AS high, mid_low AS low, mid_close AS close
  FROM ${tableName}
  ORDER BY datetime DESC
  LIMIT $maxLoadedItems
),
data AS (
  SELECT
  datetime, ${datetime_expressions} open, high, low, close
  FROM T
  ORDER BY datetime ASC
  LIMIT 18446744073709551615 -- See https://mariadb.com/kb/en/why-is-order-by-in-a-from-subquery-ignored/
),
indicators AS (
  SELECT
  $result
  FROM data
  ORDER BY datetime ASC
  LIMIT 18446744073709551615 -- See https://mariadb.com/kb/en/why-is-order-by-in-a-from-subquery-ignored/
)
SELECT * FROM indicators
$WHERE_FILTER
ORDER BY datetime DESC
LIMIT $itemCount
";

return $sql;

}

sub _getSignalSql {
my ($self, $args) = @_;

    my @good_args           = qw(provider timeframe expression instrument max_loaded_items start_period end_period item_count fields);

    foreach my $key (keys %$args) {
        $self->{_logger}->logconfess("invalid arg in _getSignalSql: $key") unless grep { /$key/ } @good_args;
    }

    my $tf_name = $args->{timeframe} || $args->{tf} || 'day';
    my $tf = $self->{_ds}->cfg->timeframes->getTimeframeID($tf_name);
    $self->{_logger}->logconfess( "Could not understand timeframe " . ( $tf_name ) ) if (!$tf);
    my $expr   = $args->{expression} || $args->{expr}   || $self->{_logger}->logconfess("No expression set for signal");
    $expr = lc($expr);
    my $instrument = $args->{instrument} || $args->{symbol} || $self->{_logger}->logconfess("No instrument set");
    my $maxLoadedItems = $args->{max_loaded_items} || $args->{maxLoadedItems} || 10_000_000_000;
    my $displayStartDate = $args->{start_period} || $args->{startPeriod} || '0001-01-01 00:00:00';
    my $displayEndDate = $args->{end_period} || $args->{endPeriod} || '9999-12-31 23:59:59';
    my $fields = $args->{fields} || 'datetime';
    my $provider = $args->{provider};

    my $data_provider = $self->{_ds}->cfg->provider($provider);

    my $itemCount = $args->{item_count} || $args->{numItems} || $maxLoadedItems;

    %INDICATORS = ();
    @VALUES     = ();
    my $results  = $self->{_parser}->start_signal( \$expr );

    #use Data::Dumper;
    #print "INDICATOR_TIMEFRAMES = " . Dumper(\@INDICATOR_TIMEFRAMES);
    #print "DATETIME = " . Dumper(\%DATETIMES);
    #print "INDICATORS = " . Dumper(\%INDICATORS);
    #print "VALUES = " . Dumper(\@VALUES);
    #print "results = " . Dumper(\$results);

    $self->{_logger}->logdie("Syntax error in signal \n\n$expr\n") unless ( defined($results) );

    my $tableName = $data_provider->getTableName($instrument, $tf);

    #my $datetime_labels = join(', ', map {"datetime_${_}"} keys %DATETIMES);
    use Finance::HostedTrader::Synthetics;
    my $datetime_expressions = join(', ', map { Finance::HostedTrader::Synthetics::getDateFormat($_) . " AS datetime_${_}" } keys %DATETIMES);
    $datetime_expressions .= ',' if ($datetime_expressions);

    my $WHERE_FILTER = "(datetime >= '$displayStartDate' AND datetime <= '$displayEndDate')";

    my %query_items;
    foreach my $result (@$results) {
        next unless ($result =~ /^\d+$/);
        foreach my $item ( @{ $VALUES[$result]->{items} }) {
            $query_items{$item} = $INDICATORS{$item};
        }
    }

    my $select_items = join(",\n  ", ('datetime', map { "$_ AS F" . $query_items{$_} } keys %query_items));

    my @pp = map { ($_ =~ /^\d+$/ ? $VALUES[$_] : $_) } @$results;
    #print "PP=" . Dumper(\@pp);
    my @ppp = map { (ref($_) eq 'HASH' ? "F" . $INDICATORS{$_->{items}[0]} . " " . $_->{type} . " F" . $INDICATORS{$_->{items}[1]} : $_) } @pp;

    #print "PPP=" . Dumper(\@ppp);

    my $signal_where_filter = join(" ", map { s/cmpop//;$_ } @ppp);


    my $sql = "
WITH T AS (
  SELECT datetime, mid_open AS open, mid_high AS high, mid_low AS low, mid_close AS close
  FROM ${tableName}
  ORDER BY datetime DESC
  LIMIT $maxLoadedItems
),
data AS (
  SELECT
  datetime,${datetime_expressions} open, high, low, close
  FROM T
  ORDER BY datetime ASC
  LIMIT 18446744073709551615 -- See https://mariadb.com/kb/en/why-is-order-by-in-a-from-subquery-ignored/
),
indicators AS (
  SELECT
  $select_items
  FROM data
  ORDER BY datetime ASC
  LIMIT 18446744073709551615 -- See https://mariadb.com/kb/en/why-is-order-by-in-a-from-subquery-ignored/
)
SELECT datetime FROM indicators
WHERE ($signal_where_filter) AND $WHERE_FILTER
ORDER BY datetime DESC
LIMIT $itemCount
";

    return $sql;
}

=method C<checkSignal>
Check wether a given signal occurred in a given period of time
=cut
sub checkSignal {
    my ( $self, $args ) = @_;

    my @good_args = qw(provider expr instrument symbol tf maxLoadedItems period simulatedNowValue);

    foreach my $key (keys %$args) {
        $self->{_logger}->logconfess("invalid arg in checkSignal: $key") unless grep { /$key/ } @good_args;
    }

    my $expr = $args->{expr} || $self->{_logger}->logconfess("expr argument missing in checkSignal");
    my $instrument = $args->{instrument} || $args->{symbol} || $self->{_logger}->logconfess("instrument argument missing in checkSignal");
    my $timeframe = $args->{tf} || $self->{_logger}->logconfess("timeframe argument missing in checkSignal");
    my $maxLoadedItems = $args->{maxLoadedItems} || -1;
    my $period = $args->{period} || 3600;
    my $nowValue = $args->{simulatedNowValue} || 'now';
    my $provider = $args->{provider};

    my $startPeriod = UnixDate(DateCalc($nowValue, '- '.$period."seconds"), '%Y-%m-%d %H:%M:%S');
    my $endPeriod = UnixDate($nowValue, '%Y-%m-%d %H:%M:%S');
    my $signal_result = $self->getSignalData(
        {
            'provider'        => $provider,
            'expr'            => $expr,
            'instrument'      => $instrument,
            'tf'              => $timeframe,
            'maxLoadedItems'  => $maxLoadedItems,
            'startPeriod'     => $startPeriod,
            'endPeriod'       => $endPeriod,
            'numItems'        => 1,
        }
    );
    my $data = $signal_result->{data};

    return $data->[0] if defined($data);
}
1;
