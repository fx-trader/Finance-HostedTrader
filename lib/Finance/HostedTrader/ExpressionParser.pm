package Finance::HostedTrader::ExpressionParser;
# ABSTRACT: Finance::HostedTrader::ExpressionParser - Utility object to calculate indicators/signals based on complex expressions
#Maybe one day convert this to lex/bison
#http://www.scribd.com/doc/8669780/Lex-yacc-Tutorial
use strict;
use warnings;
use Date::Manip;
use Log::Log4perl qw(:easy);
use List::Util;
use Parse::RecDescent;
use Finance::HostedTrader::Datasource;

my ( %TIMEFRAMES, %INDICATORS, @VALUES );

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

sub setSignalTimeframe {
    my ($sig, $tf) = @_;

    my $key = join (' ', @$sig);
    $TIMEFRAMES{$key} = $tf;
}

#$::RD_TRACE=1;
$::RD_HINT   = 1;
$::RD_WARN   = 1;
$::RD_ERRORS = 1;

sub new {
    my ( $class, $ds ) = @_;

    my $grammar = q {
start_indicator:          statement_indicator /\Z/               {$item[1]}

start_signal:          recursive_timeframe_statement_signal /\Z/               {$item[1]}

statement_indicator:		expression(s /,/) {join(',', map { (/^[0-9]/ ? $_ : "$_") } @{$item[1]})}

recursive_timeframe_statement_signal:       <leftop: timeframe_statement_signal boolop timeframe_statement_signal >     { $item[1] }

timeframe_statement_signal:     'daily' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 86400); $item[3] }
                              | '4hourly' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 14400); $item[3] }
                              | '3hourly' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 10800); $item[3] }
                              | '2hourly' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 7200); $item[3] }
                              | 'hourly' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 3600); $item[3] }
                              | '30minutely' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 1800); $item[3] }
                              | '15minutely' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 900); $item[3] }
                              | '5minutely' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 300); $item[3] }
                              | '2minutely' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 120); $item[3] }
                              | 'minutely' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 60); $item[3] }
                              | '30seconds' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 30); $item[3] }
                              | '15seconds' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 15); $item[3] }
                              | '5seconds' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 5); $item[3] }
                              | 'second' '(' statement_signal ')'   { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 1); $item[3] }
                              | statement_signal

statement_signal:		<leftop: signal boolop signal > { $item[1] }

statement: statement_indicator | statement_signal

boolop:	'AND' | 'OR'

signal:
			    'crossoverup' '(' expression ',' number ')' { my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverup","ta_previous($item[3],1)", $item[5], $item[3], $item[5]); $key }
			  | 'crossoverup' '(' expression ',' expression ')' { my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverup","ta_previous($item[3],1)", "ta_previous($item[5],1)", $item[3], $item[5]); $key }
			  | 'crossoverdown' '(' expression ',' number ')' { my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverdown","ta_previous($item[3],1)", $item[5], $item[3], $item[5]); $key }
			  | 'crossoverdown' '(' expression ',' expression ')' { my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverdown","ta_previous($item[3],1)", "ta_previous($item[5],1)", $item[3], $item[5]); $key }
              | expression cmp_op expression      { my $key = Finance::HostedTrader::ExpressionParser::getID("cmpop$item[2]",$item[1],$item[3]); $key }
              | expression

cmp_op:         '>=' | '>' | '<=' | '<'

expression:     term math_op expression      {"$item[1] $item[2] $item[3]"}
              | term

math_op:        '+' | '-' | '*' | '/'

term:           number
              | field
              | function
              | '(' statement ')'        {"($item[2])"}

number:         /-?\d+(\.\d+)?/

field:			"datetime" | "open" | "high" | "low" | "close"

function:
		'ema(' expression ',' number ')' { "round(ta_ema($item[2],$item[4]), 4)" } |
		'sma(' expression ',' number ')' { "round(ta_sma($item[2],$item[4]), 4)" } |
		'rsi(' expression ',' number ')' { "round(ta_rsi($item[2],$item[4]), 2)" } |
		'max(' expression ',' number ')' { "ta_max($item[2],$item[4])" } |
		'min(' expression ',' number ')' { "ta_min($item[2],$item[4])" } |
		'tr(' ')'  { "round(ta_tr(high,low,close), 4)" } |
		'atr(' number ')'  { "round(ta_ema(ta_tr(high,low,close),$item[2]), 4)" } |
		'previous(' expression ',' number ')' { "ta_previous($item[2],$item[4])" } |
		'bolhigh(' expression ',' number ',' number ')' { "round(ta_sma($item[2],$item[4]) + $item[6]*ta_stddevp($item[2], $item[4]), 4)" } |
		'bollow(' expression ',' number ',' number ')' { "round(ta_sma($item[2],$item[4]) - $item[6]*ta_stddevp($item[2], $item[4]), 4)" } |
		'trend(' expression ',' number ')' { "round(($item[2] - ta_sma($item[2],$item[4])) / (SQRT(ta_sum(POW($item[2] - ta_sma($item[2], $item[4]), 2), $item[4])/$item[4])), 2)" } |
		'macd(' expression ',' number ',' number ',' number ')' { "round(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]), 4)" } |
		'macdsig(' expression ',' number ',' number ',' number ')' { "round(ta_ema(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]),$item[8]),4)" } |
		'macddiff(' expression ',' number ',' number ',' number ')' { "round((ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6])) - (ta_ema(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]),$item[8])),4)" } |
		'abs(' expression ')' { "round(abs($item[2]), 4)" }
};

# Sample function calls
# macddiff( dataset, shortperiodema, longperiodema, signalema), macddiff(12,26,9)

    my $parser    = Parse::RecDescent->new($grammar);

    if (!Log::Log4perl->initialized()) {
        if ( -r "/etc/fxtrader/hostedtrader.log.conf" ) {
            Log::Log4perl->init("/etc/fxtrader/hostedtrader.log.conf");
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

=method C<getIndicatorData>

args

tf
fields
symbol
maxLoadedItems
endPeriod
numItems

=cut
sub getIndicatorData {
    my ( $self, $args ) = @_;

    my $itemCount = $args->{numItems} || 10_000_000;


    my $sql = $self->_getIndicatorSql(%$args);
    $self->{_logger}->debug($sql);

    my $dbh = $self->{_ds}->dbh;
    my $data = $dbh->selectall_arrayref($sql) or $self->{_logger}->logconfess($DBI::errstr);
    my $lastItemIndex = scalar(@$data) - 1;
    # Return only the last $itemCount elements. 
    # Originally this was implemented as a limit clause in the SQL query, but that stopped 
    # working after MariaDB 5.5
    if ( defined($itemCount) && ( $lastItemIndex > $itemCount ) ) {
        my @slice =
          @{$data}[ $lastItemIndex - $itemCount + 1 .. $lastItemIndex ];
        return \@slice;
    }

    return $data;
}

=method C<getSignalData>
See L</getIndicatorData> for list of arguments.
=cut
sub getSignalData {
    my ( $self, $args ) = @_;
    my $sql = $self->_getSignalSql($args);
    $self->{_logger}->debug($sql);

    my $dbh = $self->{_ds}->dbh;
    my $data = $dbh->selectall_arrayref($sql) or $self->{_logger}->logconfess( $DBI::errstr . $sql );
    return $data;
}

=method C<getSystemData>
=cut
sub getSystemData {
    my ( $self, $a ) = @_;

    my %args = %{ $a };

    $args{expr} = delete $args{enter};
    my $exitSignal = delete $args{exit};
    $args{fields} = "'ENTRY' AS Action, datetime, close";
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

sub _getSignalSql {
my ($self, $args) = @_;

    my @good_args = qw(tf expr symbol maxLoadedItems startPeriod endPeriod numItems fields);

    foreach my $key (keys %$args) {
        $self->{_logger}->logconfess("invalid arg in _getSignalSql: $key") unless grep { /$key/ } @good_args;
    }

    my $tf_name = $args->{tf} || 'day';
    my $default_tf = $self->{_ds}->cfg->timeframes->getTimeframeID($tf_name);
    $self->{_logger}->logconfess( "Could not understand timeframe " . ( $tf_name ) ) if (!$default_tf);
    my $expr   = $args->{expr}   || $self->{_logger}->logconfess("No expression set for signal");
    my $symbol = $args->{symbol} || $self->{_logger}->logconfess("No symbol set");
    my $maxLoadedItems = $args->{maxLoadedItems};
    my $startPeriod = $args->{startPeriod} || '0001-01-01 00:00:00';
    my $endPeriod = $args->{endPeriod} || '9999-12-31 23:59:59';
    my $fields = $args->{fields} || 'datetime';
    my $nbItems = $args->{numItems} || 10_000_000_000;

    $maxLoadedItems = 10_000_000_000
      if ( !defined( $args->{maxLoadedItems} ));

    %TIMEFRAMES = ();
    %INDICATORS = ();
    @VALUES     = ();
    my $results = $self->{_parser}->start_signal( $args->{expr} );
    use Data::Dumper;
    #print "TIMEFRAMES = " . Dumper(\%TIMEFRAMES);
    #print "INDICATORS = " . Dumper(\%INDICATORS);
    #print "VALUES = " . Dumper(\@VALUES);
    #print "results = " . Dumper(\$results);
    #exit;

    $self->{_logger}->logdie("Syntax error in signal \n\n$expr\n") unless ( defined($results) );

    my @all_timeframes_sql = ();
    my @timeframes_sql_glue = ();

    my $max_timeframe_requested = List::Util::max(values %TIMEFRAMES) || $default_tf;
    my $min_timeframe_requested = List::Util::min(values %TIMEFRAMES) || $default_tf;
    my $cfg = $self->{_ds}->cfg;
    my $common_timeframe_pattern = $cfg->timeframes->getTimeframeFormat($cfg->timeframes->getTimeframeName($max_timeframe_requested));

    foreach my $result (@$results) {

        my $result_str;
        if (!ref($result)) {
            push @timeframes_sql_glue, $result;
            next;
        }
        my $tf = $TIMEFRAMES{join(' ', @$result)} || $default_tf;
        my @fields;

        foreach my $result_signal (@$result) {
            if ($result_signal =~ /^[0-9]+$/) {
                my $value = $VALUES[$result_signal];
                my $str;

                push @fields, map { "$_ AS T$INDICATORS{$_}" } @{$value->{items}};

                if ( $value->{type} eq 'crossoverup' ) {
                    $str = "(T" . $INDICATORS{$value->{items}->[0]} . " <= T" . $INDICATORS{$value->{items}->[1]} . " AND T" . $INDICATORS{$value->{items}->[2]} . " > T" . $INDICATORS{$value->{items}->[3]} . ")";
                } elsif ( $value->{type} eq 'crossoverdown' ) {
                    $str = "(T" . $INDICATORS{$value->{items}->[0]} . " >= T" . $INDICATORS{$value->{items}->[1]} . " AND T" . $INDICATORS{$value->{items}->[2]} . " < T" . $INDICATORS{$value->{items}->[3]} . ")";
                } elsif ( $value->{type} eq 'cmpop>=' ) {
                    $str = "(T" . $INDICATORS{$value->{items}->[0]} . " >= T" . $INDICATORS{$value->{items}->[1]} . ")";
                } elsif ( $value->{type} eq 'cmpop>' ) {
                    $str = "(T" . $INDICATORS{$value->{items}->[0]} . " > T" . $INDICATORS{$value->{items}->[1]} . ")";
                } elsif ( $value->{type} eq 'cmpop<=' ) {
                    $str = "(T" . $INDICATORS{$value->{items}->[0]} . " <= T" . $INDICATORS{$value->{items}->[1]} . ")";
                } elsif ( $value->{type} eq 'cmpop<' ) {
                    $str = "(T" . $INDICATORS{$value->{items}->[0]} . " < T" . $INDICATORS{$value->{items}->[1]} . ")";
                } else {
                    die("Invalid grammar. $value->{type}");
                }
                $result_str .= $str;
            } else {
                $result_str .= ' ' . $result_signal . ' ';
            }
        }

        my %unique_fields = map { $_ => undef } @fields;

        my $select_fields = join( ', ', keys %unique_fields );
        $select_fields = ',' . $select_fields if ($select_fields);

        my $WHERE_FILTER = " WHERE datetime <= '$endPeriod'";
        $WHERE_FILTER .= ' AND dayofweek(datetime) <> 1' if ( $tf != 604800 );
        my $ORDERBY_CLAUSE='';
        $ORDERBY_CLAUSE='ORDER BY datetime';

        my $tf_sql = qq(
(
SELECT $fields, $common_timeframe_pattern AS COMMON_TIMEFRAME_PATTERN FROM (
SELECT $fields FROM (
SELECT *$select_fields
FROM (
    SELECT * FROM (
        SELECT * FROM $symbol\_$tf
        $WHERE_FILTER
        ORDER BY datetime desc
        LIMIT $maxLoadedItems
    ) AS T_LIMIT
    ORDER BY datetime
) AS T_INNER
) AS T_OUTER
WHERE $result_str AND datetime >= '$startPeriod' AND datetime <='$endPeriod'
ORDER BY datetime DESC
LIMIT $nbItems
) AS DT
$ORDERBY_CLAUSE
) AS SIGNALS_TF_$tf

);

        push @all_timeframes_sql,  {sql => $tf_sql, tf => $tf};
    }

    #print Dumper(\@all_timeframes_sql);
    #print Dumper(\@timeframes_sql_glue);

    my $sql;
    if (!@timeframes_sql_glue) {
        my $leftop = shift(@all_timeframes_sql);
        $sql = "SELECT $fields FROM $leftop->{sql}";
    } else {
        $sql = "SELECT SIGNALS_TF_$min_timeframe_requested.datetime FROM\n";
        foreach my $op (@timeframes_sql_glue) {
            my $leftop = shift(@all_timeframes_sql);
            my $rightop = shift(@all_timeframes_sql);
            die("Unexpected undefined value leftop") if (!defined($leftop));
            die("Unexpected undefined value rightop") if (!defined($rightop));

            if ($op eq 'AND') {
                $sql .= $leftop->{sql} . "\nINNER JOIN\n" . $rightop->{sql} . " ON SIGNALS_TF_$leftop->{tf}.COMMON_TIMEFRAME_PATTERN = SIGNALS_TF_$rightop->{tf}.COMMON_TIMEFRAME_PATTERN";
            } elsif ($op eq 'OR') {
                $sql .= $leftop->{sql} . "\nUNION ALL\n" . $rightop->{sql};
            } else {
                die("Unknown operator: $op");
            }
        }
    }
    return $sql;
}

sub _getIndicatorSql {
    my ($self, %args) = @_;
    my ( $result );

    my @good_args = qw(tf fields symbol maxLoadedItems endPeriod numItems);

    foreach my $key (keys %args) {
        $self->{_logger}->logconfess("invalid arg in getIndicatorData: $key") unless grep { /$key/ } @good_args;
    }

    my $tf_name = $args{tf} || 'day';
    my $tf = $self->{_ds}->cfg->timeframes->getTimeframeID($tf_name);
    $self->{_logger}->logconfess( "Could not understand timeframe " . ( $tf_name ) ) if (!$tf);
    my $maxLoadedItems = $args{maxLoadedItems};
    $maxLoadedItems = 10_000_000_000
      if ( !defined( $args{maxLoadedItems} ) );
    my $displayEndDate   = $args{endPeriod} || '9999-12-31';
    my $expr      = $args{fields}          || $self->{_logger}->logconfess("No fields set for indicator");
    my $symbol    = $args{symbol}          || $self->{_logger}->logconfess("No symbol set for indicator");

    #TODO: Refactor the parser bit so that it can be called independently. This will be usefull to validate expressions before running them.
    $result     = $self->{_parser}->start_indicator($expr);

    #TODO: Need a more meaningfull error message describing what's wrong with the given expression
    $self->{_logger}->logdie("Syntax error in indicator \n\n$expr\n")
        unless ( defined($result) );

    my $WHERE_FILTER = "WHERE datetime <= '$displayEndDate'";
#    $WHERE_FILTER .= ' AND dayofweek(datetime) <> 1' if ( $tf != 604800 );

    my $sql = qq(
SELECT $result FROM (
  SELECT * FROM $symbol\_$tf
  $WHERE_FILTER
  ORDER BY datetime DESC
  LIMIT $maxLoadedItems
) AS R
ORDER BY datetime ASC
);

}



=method C<checkSignal>
Check wether a given signal occurred in a given period of time
=cut
sub checkSignal {
    my ( $self, $args ) = @_;

    my @good_args = qw( expr symbol tf maxLoadedItems period simulatedNowValue);

    foreach my $key (keys %$args) {
        $self->{_logger}->logconfess("invalid arg in checkSignal: $key") unless grep { /$key/ } @good_args;
    }

    my $expr = $args->{expr} || $self->{_logger}->logconfess("expr argument missing in checkSignal");
    my $symbol = $args->{symbol} || $self->{_logger}->logconfess("symbol argument missing in checkSignal");
    my $timeframe = $args->{tf} || $self->{_logger}->logconfess("timeframe argument missing in checkSignal");
    my $maxLoadedItems = $args->{maxLoadedItems} || -1;
    my $period = $args->{period} || 3600;
    my $nowValue = $args->{simulatedNowValue} || 'now';

    my $startPeriod = UnixDate(DateCalc($nowValue, '- '.$period."seconds"), '%Y-%m-%d %H:%M:%S');
    my $endPeriod = UnixDate($nowValue, '%Y-%m-%d %H:%M:%S');
    my $data = $self->getSignalData(
        {
            'expr'            => $expr,
            'symbol'          => $symbol,
            'tf'              => $timeframe,
            'maxLoadedItems'  => $maxLoadedItems,
            'startPeriod'     => $startPeriod,
            'endPeriod'       => $endPeriod,
            'numItems'        => 1,
        }
    );

    return $data->[0] if defined($data);
}
1;
