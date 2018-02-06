#
# This parser was generated with
# Parse::RecDescent version 1.967013
#

package Finance::HostedTrader::ExpressionParser::Grammar;
use Parse::RecDescent;
{ my $ERRORS;


package Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar;
use strict;
use vars qw($skip $AUTOLOAD  );
@Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::ISA = ();
$skip = '\\s*';



{
local $SIG{__WARN__} = sub {0};
# PRETEND TO BE IN Parse::RecDescent NAMESPACE
*Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::AUTOLOAD   = sub
{
    no strict 'refs';

    ${"AUTOLOAD"} =~ s/^Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar/Parse::RecDescent/;
    goto &{${"AUTOLOAD"}};
}
}

push @Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::ISA, 'Parse::RecDescent';
# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::boolop
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"boolop"};

    Parse::RecDescent::_trace(q{Trying rule: [boolop]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{boolop},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{'and', or 'or'});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['and']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{boolop},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{boolop});
        %item = (__RULE__ => q{boolop});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['and']},
                      Parse::RecDescent::_tracefirst($text),
                      q{boolop},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aand/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['and']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{boolop},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['or']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{boolop},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{boolop});
        %item = (__RULE__ => q{boolop});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['or']},
                      Parse::RecDescent::_tracefirst($text),
                      q{boolop},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aor/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['or']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{boolop},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{boolop},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{boolop},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{boolop},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{boolop},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::cmp_op
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"cmp_op"};

    Parse::RecDescent::_trace(q{Trying rule: [cmp_op]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{cmp_op},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{'>=', or '>', or '<=', or '<'});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['>=']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{cmp_op});
        %item = (__RULE__ => q{cmp_op});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['>=']},
                      Parse::RecDescent::_tracefirst($text),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\>\=/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['>=']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['>']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{cmp_op});
        %item = (__RULE__ => q{cmp_op});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['>']},
                      Parse::RecDescent::_tracefirst($text),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\>/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['>']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['<=']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[2];
        $text = $_[1];
        my $_savetext;
        @item = (q{cmp_op});
        %item = (__RULE__ => q{cmp_op});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['<=']},
                      Parse::RecDescent::_tracefirst($text),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\<\=/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['<=']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['<']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[3];
        $text = $_[1];
        my $_savetext;
        @item = (q{cmp_op});
        %item = (__RULE__ => q{cmp_op});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['<']},
                      Parse::RecDescent::_tracefirst($text),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\</)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['<']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{cmp_op},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{cmp_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{cmp_op},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{cmp_op},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"expression"};

    Parse::RecDescent::_trace(q{Trying rule: [expression]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{expression},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{term});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [term math_op expression]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{expression});
        %item = (__RULE__ => q{expression});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [term]},
                  Parse::RecDescent::_tracefirst($text),
                  q{expression},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::term($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [term]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{expression},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [term]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{term}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying subrule: [math_op]},
                  Parse::RecDescent::_tracefirst($text),
                  q{expression},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{math_op})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::math_op($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [math_op]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{expression},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [math_op]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{math_op}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{expression},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{expression},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do {"$item[1] $item[2] $item[3]"};
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: [term math_op expression]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [term]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{expression});
        %item = (__RULE__ => q{expression});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [term]},
                  Parse::RecDescent::_tracefirst($text),
                  q{expression},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::term($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [term]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{expression},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [term]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{term}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{>>Matched production: [term]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{expression},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{expression},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{expression},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{expression},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::field
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"field"};

    Parse::RecDescent::_trace(q{Trying rule: [field]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{field},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{'datetime', or 'open', or 'high', or 'low', or 'close'});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['datetime']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{field});
        %item = (__RULE__ => q{field});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['datetime']},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   do { $_tok = "datetime"; 1 } and
             substr($text,0,length($_tok)) eq $_tok and
             do { substr($text,0,length($_tok)) = ""; 1; }
        )
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $_tok . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['datetime']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['open']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{field});
        %item = (__RULE__ => q{field});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['open']},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   do { $_tok = "open"; 1 } and
             substr($text,0,length($_tok)) eq $_tok and
             do { substr($text,0,length($_tok)) = ""; 1; }
        )
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $_tok . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['open']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['high']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[2];
        $text = $_[1];
        my $_savetext;
        @item = (q{field});
        %item = (__RULE__ => q{field});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['high']},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   do { $_tok = "high"; 1 } and
             substr($text,0,length($_tok)) eq $_tok and
             do { substr($text,0,length($_tok)) = ""; 1; }
        )
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $_tok . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['high']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['low']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[3];
        $text = $_[1];
        my $_savetext;
        @item = (q{field});
        %item = (__RULE__ => q{field});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['low']},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   do { $_tok = "low"; 1 } and
             substr($text,0,length($_tok)) eq $_tok and
             do { substr($text,0,length($_tok)) = ""; 1; }
        )
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $_tok . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['low']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['close']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[4];
        $text = $_[1];
        my $_savetext;
        @item = (q{field});
        %item = (__RULE__ => q{field});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['close']},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   do { $_tok = "close"; 1 } and
             substr($text,0,length($_tok)) eq $_tok and
             do { substr($text,0,length($_tok)) = ""; 1; }
        )
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $_tok . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['close']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{field},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{field},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{field},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{field},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::function
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"function"};

    Parse::RecDescent::_trace(q{Trying rule: [function]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{'ema(', or 'sma(', or 'rsi(', or 'max(', or 'min(', or 'tr(', or 'atr(', or 'previous(', or 'bolhigh(', or 'bollow(', or 'trend(', or 'macd(', or 'macdsig(', or 'macddiff(', or 'abs(', or 'weekday(', or 'dayname('});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['ema(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['ema(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aema\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_ema($item[2],$item[4]), 4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['ema(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['sma(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['sma(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Asma\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_sma($item[2],$item[4]), 4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['sma(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['rsi(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[2];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['rsi(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Arsi\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_rsi($item[2],$item[4]), 2)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['rsi(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['max(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[3];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['max(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Amax\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "ta_max($item[2],$item[4])" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['max(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['min(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[4];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['min(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Amin\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "ta_min($item[2],$item[4])" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['min(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['tr(' ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[5];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['tr(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Atr\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_tr(high,low,close), 4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['tr(' ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['atr(' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[6];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['atr(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aatr\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_ema(ta_tr(high,low,close),$item[2]), 4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['atr(' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['previous(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[7];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['previous(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aprevious\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "ta_previous($item[2],$item[4])" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['previous(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['bolhigh(' expression ',' number ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[8];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['bolhigh(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Abolhigh\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_sma($item[2],$item[4]) + $item[6]*ta_stddevp($item[2], $item[4]), 4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['bolhigh(' expression ',' number ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['bollow(' expression ',' number ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[9];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['bollow(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Abollow\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_sma($item[2],$item[4]) - $item[6]*ta_stddevp($item[2], $item[4]), 4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['bollow(' expression ',' number ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['trend(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[10];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['trend(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Atrend\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(($item[2] - ta_sma($item[2],$item[4])) / (SQRT(ta_sum(POW($item[2] - ta_sma($item[2], $item[4]), 2), $item[4])/$item[4])), 2)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['trend(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['macd(' expression ',' number ',' number ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[11];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['macd(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Amacd\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING5__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]), 4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['macd(' expression ',' number ',' number ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['macdsig(' expression ',' number ',' number ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[12];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['macdsig(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Amacdsig\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING5__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(ta_ema(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]),$item[8]),4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['macdsig(' expression ',' number ',' number ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['macddiff(' expression ',' number ',' number ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[13];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['macddiff(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Amacddiff\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING5__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round((ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6])) - (ta_ema(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]),$item[8])),4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['macddiff(' expression ',' number ',' number ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['abs(' expression ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[14];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['abs(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aabs\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "round(abs($item[2]), 4)" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['abs(' expression ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['weekday(' expression ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[15];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['weekday(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aweekday\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "weekday($item[2])" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['weekday(' expression ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['dayname(' expression ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[16];
        $text = $_[1];
        my $_savetext;
        @item = (q{function});
        %item = (__RULE__ => q{function});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['dayname(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Adayname\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{function},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{function},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { "dayname($item[2])" };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['dayname(' expression ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{function},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{function},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{function},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{function},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::math_op
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"math_op"};

    Parse::RecDescent::_trace(q{Trying rule: [math_op]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{math_op},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{'+', or '-', or '*', or '/'});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['+']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{math_op});
        %item = (__RULE__ => q{math_op});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['+']},
                      Parse::RecDescent::_tracefirst($text),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\+/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['+']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['-']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{math_op});
        %item = (__RULE__ => q{math_op});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['-']},
                      Parse::RecDescent::_tracefirst($text),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\-/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['-']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['*']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[2];
        $text = $_[1];
        my $_savetext;
        @item = (q{math_op});
        %item = (__RULE__ => q{math_op});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['*']},
                      Parse::RecDescent::_tracefirst($text),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\*/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['*']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['/']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[3];
        $text = $_[1];
        my $_savetext;
        @item = (q{math_op});
        %item = (__RULE__ => q{math_op});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['/']},
                      Parse::RecDescent::_tracefirst($text),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\//)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['/']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{math_op},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{math_op},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{math_op},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{math_op},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"number"};

    Parse::RecDescent::_trace(q{Trying rule: [number]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{number},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{/-?\\d+(\\.\\d+)?/});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [/-?\\d+(\\.\\d+)?/]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{number},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{number});
        %item = (__RULE__ => q{number});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: [/-?\\d+(\\.\\d+)?/]}, Parse::RecDescent::_tracefirst($text),
                      q{number},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A(?:-?\d+(\.\d+)?)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                    if defined $::RD_TRACE;

            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                    if defined $::RD_TRACE;
        push @item, $item{__PATTERN1__}=$current_match;
        

        Parse::RecDescent::_trace(q{>>Matched production: [/-?\\d+(\\.\\d+)?/]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{number},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{number},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{number},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{number},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{number},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::recursive_timeframe_statement_signal
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"recursive_timeframe_statement_signal"};

    Parse::RecDescent::_trace(q{Trying rule: [recursive_timeframe_statement_signal]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{recursive_timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{<leftop: timeframe_statement_signal boolop timeframe_statement_signal>});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [<leftop: timeframe_statement_signal boolop timeframe_statement_signal>]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{recursive_timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{recursive_timeframe_statement_signal});
        %item = (__RULE__ => q{recursive_timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying operator: [<leftop: timeframe_statement_signal boolop timeframe_statement_signal>]},
                  Parse::RecDescent::_tracefirst($text),
                  q{recursive_timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        $expectation->is(q{})->at($text);

        $_tok = undef;
        OPLOOP: while (1)
        {
          $repcount = 0;
          my @item;
          my %item;

          # MATCH LEFTARG
          
        Parse::RecDescent::_trace(q{Trying subrule: [timeframe_statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{recursive_timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{timeframe_statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::timeframe_statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [timeframe_statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{recursive_timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [timeframe_statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{recursive_timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{timeframe_statement_signal}} = $_tok;
        push @item, $_tok;
        
        }



          $repcount++;

          my $savetext = $text;
          my $backtrack;

          # MATCH (OP RIGHTARG)(s)
          while ($repcount < 100000000)
          {
            $backtrack = 0;
            
        Parse::RecDescent::_trace(q{Trying subrule: [boolop]},
                  Parse::RecDescent::_tracefirst($text),
                  q{recursive_timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{boolop})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::boolop($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [boolop]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{recursive_timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [boolop]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{recursive_timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{boolop}} = $_tok;
        push @item, $_tok;
        
        }

            $backtrack=1;
            
            
        Parse::RecDescent::_trace(q{Trying subrule: [timeframe_statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{recursive_timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{timeframe_statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::timeframe_statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [timeframe_statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{recursive_timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [timeframe_statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{recursive_timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{timeframe_statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

            $savetext = $text;
            $repcount++;
          }
          $text = $savetext;
          pop @item if $backtrack;

          unless (@item) { undef $_tok; last }
          $_tok = [ @item ];

          last;
        } # end of OPLOOP

        unless ($repcount>=1)
        {
            Parse::RecDescent::_trace(q{<<Didn't match operator: [<leftop: timeframe_statement_signal boolop timeframe_statement_signal>]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{recursive_timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched operator: [<leftop: timeframe_statement_signal boolop timeframe_statement_signal>]<< (return value: [}
                      . qq{@{$_tok||[]}} . q{]},
                      Parse::RecDescent::_tracefirst($text),
                      q{recursive_timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;

        push @item, $item{__DIRECTIVE1__}=$_tok||[];

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{recursive_timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { $item[1] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: [<leftop: timeframe_statement_signal boolop timeframe_statement_signal>]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{recursive_timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{recursive_timeframe_statement_signal},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{recursive_timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{recursive_timeframe_statement_signal},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{recursive_timeframe_statement_signal},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::signal
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"signal"};

    Parse::RecDescent::_trace(q{Trying rule: [signal]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{'crossoverup', or 'crossoverdown', or expression});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['crossoverup' '(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{signal});
        %item = (__RULE__ => q{signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['crossoverup']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Acrossoverup/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverup","ta_previous($item[3],1)", $item[5], $item[3], $item[5]); $key };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['crossoverup' '(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['crossoverup' '(' expression ',' expression ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{signal});
        %item = (__RULE__ => q{signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['crossoverup']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Acrossoverup/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverup","ta_previous($item[3],1)", "ta_previous($item[5],1)", $item[3], $item[5]); $key };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['crossoverup' '(' expression ',' expression ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['crossoverdown' '(' expression ',' number ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[2];
        $text = $_[1];
        my $_savetext;
        @item = (q{signal});
        %item = (__RULE__ => q{signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['crossoverdown']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Acrossoverdown/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{number})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverdown","ta_previous($item[3],1)", $item[5], $item[3], $item[5]); $key };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['crossoverdown' '(' expression ',' number ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['crossoverdown' '(' expression ',' expression ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[3];
        $text = $_[1];
        my $_savetext;
        @item = (q{signal});
        %item = (__RULE__ => q{signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['crossoverdown']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Acrossoverdown/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [',']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{','})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\,/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING4__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverdown","ta_previous($item[3],1)", "ta_previous($item[5],1)", $item[3], $item[5]); $key };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['crossoverdown' '(' expression ',' expression ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [expression cmp_op expression]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[4];
        $text = $_[1];
        my $_savetext;
        @item = (q{signal});
        %item = (__RULE__ => q{signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying subrule: [cmp_op]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{cmp_op})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::cmp_op($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [cmp_op]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [cmp_op]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{cmp_op}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { my $key = Finance::HostedTrader::ExpressionParser::getID("cmpop$item[2]",$item[1],$item[3]); $key };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: [expression cmp_op expression]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [expression]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[5];
        $text = $_[1];
        my $_savetext;
        @item = (q{signal});
        %item = (__RULE__ => q{signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{>>Matched production: [expression]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{signal},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{signal},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{signal},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::start_indicator
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"start_indicator"};

    Parse::RecDescent::_trace(q{Trying rule: [start_indicator]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{start_indicator},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{statement_indicator});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [statement_indicator /\\Z/]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{start_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{start_indicator});
        %item = (__RULE__ => q{start_indicator});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [statement_indicator]},
                  Parse::RecDescent::_tracefirst($text),
                  q{start_indicator},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_indicator($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_indicator]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{start_indicator},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_indicator]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{start_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_indicator}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [/\\Z/]}, Parse::RecDescent::_tracefirst($text),
                      q{start_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{/\\Z/})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A(?:\Z)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                    if defined $::RD_TRACE;

            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                    if defined $::RD_TRACE;
        push @item, $item{__PATTERN1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{start_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do {$item[1]};
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: [statement_indicator /\\Z/]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{start_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{start_indicator},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{start_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{start_indicator},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{start_indicator},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::start_signal
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"start_signal"};

    Parse::RecDescent::_trace(q{Trying rule: [start_signal]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{start_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{recursive_timeframe_statement_signal});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [recursive_timeframe_statement_signal /\\Z/]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{start_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{start_signal});
        %item = (__RULE__ => q{start_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [recursive_timeframe_statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{start_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::recursive_timeframe_statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [recursive_timeframe_statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{start_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [recursive_timeframe_statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{start_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{recursive_timeframe_statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [/\\Z/]}, Parse::RecDescent::_tracefirst($text),
                      q{start_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{/\\Z/})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A(?:\Z)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                    if defined $::RD_TRACE;

            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                    if defined $::RD_TRACE;
        push @item, $item{__PATTERN1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{start_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do {$item[1]};
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: [recursive_timeframe_statement_signal /\\Z/]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{start_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{start_signal},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{start_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{start_signal},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{start_signal},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"statement"};

    Parse::RecDescent::_trace(q{Trying rule: [statement]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{statement},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{statement_indicator, or statement_signal});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [statement_indicator]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{statement},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{statement});
        %item = (__RULE__ => q{statement});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [statement_indicator]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_indicator($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_indicator]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_indicator]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{statement},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_indicator}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{>>Matched production: [statement_indicator]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{statement},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [statement_signal]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{statement},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{statement});
        %item = (__RULE__ => q{statement});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{statement},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{>>Matched production: [statement_signal]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{statement},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{statement},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{statement},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{statement},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{statement},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_indicator
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"statement_indicator"};

    Parse::RecDescent::_trace(q{Trying rule: [statement_indicator]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{statement_indicator},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{<leftop: expression /,/ expression>});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [<leftop: expression /,/ expression>]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{statement_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{statement_indicator});
        %item = (__RULE__ => q{statement_indicator});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying operator: [<leftop: expression /,/ expression>]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement_indicator},
                  $tracelevel)
                    if defined $::RD_TRACE;
        $expectation->is(q{})->at($text);

        $_tok = undef;
        OPLOOP: while (1)
        {
          $repcount = 0;
          my @item;
          my %item;

          # MATCH LEFTARG
          
        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement_indicator},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement_indicator},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{statement_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }



          $repcount++;

          my $savetext = $text;
          my $backtrack;

          # MATCH (OP RIGHTARG)(s)
          while ($repcount < 100000000)
          {
            $backtrack = 0;
            
        Parse::RecDescent::_trace(q{Trying terminal: [/,/]}, Parse::RecDescent::_tracefirst($text),
                      q{statement_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{/,/})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A(?:,)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            $expectation->failed();
            Parse::RecDescent::_trace(q{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                    if defined $::RD_TRACE;

            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                    if defined $::RD_TRACE;
        push @item, $item{__PATTERN1__}=$current_match;
        

            pop @item;
            if (defined $1) {push @item, $item{'expression(s)'}=$1; $backtrack=1;}
            
        Parse::RecDescent::_trace(q{Trying subrule: [expression]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement_indicator},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{expression})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::expression($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [expression]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement_indicator},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [expression]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{statement_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{expression}} = $_tok;
        push @item, $_tok;
        
        }

            $savetext = $text;
            $repcount++;
          }
          $text = $savetext;
          pop @item if $backtrack;

          unless (@item) { undef $_tok; last }
          $_tok = [ @item ];

          last;
        } # end of OPLOOP

        unless ($repcount>=1)
        {
            Parse::RecDescent::_trace(q{<<Didn't match operator: [<leftop: expression /,/ expression>]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement_indicator},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched operator: [<leftop: expression /,/ expression>]<< (return value: [}
                      . qq{@{$_tok||[]}} . q{]},
                      Parse::RecDescent::_tracefirst($text),
                      q{statement_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;

        push @item, $item{'expression(s)'}=$_tok||[];

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{statement_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do {join(',', map { (/^[0-9]/ ? $_ : "$_") } @{$item[1]})};
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: [<leftop: expression /,/ expression>]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{statement_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{statement_indicator},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{statement_indicator},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{statement_indicator},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{statement_indicator},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"statement_signal"};

    Parse::RecDescent::_trace(q{Trying rule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{<leftop: signal boolop signal>});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [<leftop: signal boolop signal>]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{statement_signal});
        %item = (__RULE__ => q{statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying operator: [<leftop: signal boolop signal>]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        $expectation->is(q{})->at($text);

        $_tok = undef;
        OPLOOP: while (1)
        {
          $repcount = 0;
          my @item;
          my %item;

          # MATCH LEFTARG
          
        Parse::RecDescent::_trace(q{Trying subrule: [signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{signal}} = $_tok;
        push @item, $_tok;
        
        }



          $repcount++;

          my $savetext = $text;
          my $backtrack;

          # MATCH (OP RIGHTARG)(s)
          while ($repcount < 100000000)
          {
            $backtrack = 0;
            
        Parse::RecDescent::_trace(q{Trying subrule: [boolop]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{boolop})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::boolop($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [boolop]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [boolop]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{boolop}} = $_tok;
        push @item, $_tok;
        
        }

            $backtrack=1;
            
            
        Parse::RecDescent::_trace(q{Trying subrule: [signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{signal}} = $_tok;
        push @item, $_tok;
        
        }

            $savetext = $text;
            $repcount++;
          }
          $text = $savetext;
          pop @item if $backtrack;

          unless (@item) { undef $_tok; last }
          $_tok = [ @item ];

          last;
        } # end of OPLOOP

        unless ($repcount>=1)
        {
            Parse::RecDescent::_trace(q{<<Didn't match operator: [<leftop: signal boolop signal>]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched operator: [<leftop: signal boolop signal>]<< (return value: [}
                      . qq{@{$_tok||[]}} . q{]},
                      Parse::RecDescent::_tracefirst($text),
                      q{statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;

        push @item, $item{__DIRECTIVE1__}=$_tok||[];

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { $item[1] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: [<leftop: signal boolop signal>]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{statement_signal},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{statement_signal},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{statement_signal},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::term
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"term"};

    Parse::RecDescent::_trace(q{Trying rule: [term]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{term},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{number, or field, or function, or '('});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [number]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{term});
        %item = (__RULE__ => q{term});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [number]},
                  Parse::RecDescent::_tracefirst($text),
                  q{term},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::number($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [number]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{term},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [number]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{number}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{>>Matched production: [number]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [field]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{term});
        %item = (__RULE__ => q{term});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [field]},
                  Parse::RecDescent::_tracefirst($text),
                  q{term},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::field($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [field]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{term},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [field]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{field}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{>>Matched production: [field]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [function]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[2];
        $text = $_[1];
        my $_savetext;
        @item = (q{term});
        %item = (__RULE__ => q{term});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [function]},
                  Parse::RecDescent::_tracefirst($text),
                  q{term},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::function($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [function]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{term},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [function]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{function}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{>>Matched production: [function]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['(' statement ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[3];
        $text = $_[1];
        my $_savetext;
        @item = (q{term});
        %item = (__RULE__ => q{term});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement]},
                  Parse::RecDescent::_tracefirst($text),
                  q{term},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{term},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do {"($item[2])"};
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['(' statement ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{term},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{term},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{term},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{term},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}

# ARGS ARE: ($parser, $text; $repeating, $_noactions, \@args, $_itempos)
sub Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::timeframe_statement_signal
{
	my $thisparser = $_[0];
	use vars q{$tracelevel};
	local $tracelevel = ($tracelevel||0)+1;
	$ERRORS = 0;
    my $thisrule = $thisparser->{"rules"}{"timeframe_statement_signal"};

    Parse::RecDescent::_trace(q{Trying rule: [timeframe_statement_signal]},
                  Parse::RecDescent::_tracefirst($_[1]),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;

    
    my $err_at = @{$thisparser->{errors}};

    my $score;
    my $score_return;
    my $_tok;
    my $return = undef;
    my $_matched=0;
    my $commit=0;
    my @item = ();
    my %item = ();
    my $repeating =  $_[2];
    my $_noactions = $_[3];
    my @arg =    defined $_[4] ? @{ &{$_[4]} } : ();
    my $_itempos = $_[5];
    my %arg =    ($#arg & 01) ? @arg : (@arg, undef);
    my $text;
    my $lastsep;
    my $current_match;
    my $expectation = new Parse::RecDescent::Expectation(q{'day', or '4hour', or '3hour', or '2hour', or 'hour', or '30minute', or '15minute', or '5minute', or '2minute', or 'minute', or '30second', or '15second', or '5second', or 'second', or statement_signal});
    $expectation->at($_[1]);
    
    my $thisline;
    tie $thisline, q{Parse::RecDescent::LineCounter}, \$text, $thisparser;

    

    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['day' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[0];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['day']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aday/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 86400); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['day' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['4hour' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[1];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['4hour']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A4hour/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 14400); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['4hour' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['3hour' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[2];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['3hour']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A3hour/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 10800); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['3hour' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['2hour' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[3];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['2hour']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A2hour/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 7200); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['2hour' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['hour' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[4];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['hour']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Ahour/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 3600); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['hour' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['30minute' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[5];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['30minute']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A30minute/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 1800); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['30minute' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['15minute' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[6];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['15minute']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A15minute/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 900); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['15minute' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['5minute' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[7];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['5minute']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A5minute/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 300); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['5minute' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['2minute' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[8];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['2minute']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A2minute/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 120); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['2minute' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['minute' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[9];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['minute']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Aminute/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 60); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['minute' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['30second' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[10];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['30second']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A30second/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 30); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['30second' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['15second' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[11];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['15second']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A15second/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 15); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['15second' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['5second' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[12];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['5second']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A5second/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 5); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['5second' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: ['second' '(' statement_signal ')']},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[13];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying terminal: ['second']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\Asecond/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING1__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying terminal: ['(']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{'('})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\(/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING2__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{statement_signal})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{Trying terminal: [')']},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        undef $lastsep;
        $expectation->is(q{')'})->at($text);
        

        unless ($text =~ s/\A($skip)/$lastsep=$1 and ""/e and   $text =~ m/\A\)/)
        {
            $text = $lastsep . $text if defined $lastsep;
            
            $expectation->failed();
            Parse::RecDescent::_trace(qq{<<Didn't match terminal>>},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
            last;
        }
        $current_match = substr($text, $-[0], $+[0] - $-[0]);
        substr($text,0,length($current_match),q{});
        Parse::RecDescent::_trace(q{>>Matched terminal<< (return value: [}
                        . $current_match . q{])},
                          Parse::RecDescent::_tracefirst($text))
                            if defined $::RD_TRACE;
        push @item, $item{__STRING3__}=$current_match;
        

        Parse::RecDescent::_trace(q{Trying action},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        

        $_tok = ($_noactions) ? 0 : do { Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 1); $item[3] };
        unless (defined $_tok)
        {
            Parse::RecDescent::_trace(q{<<Didn't match action>> (return value: [undef])})
                    if defined $::RD_TRACE;
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched action<< (return value: [}
                      . $_tok . q{])},
                      Parse::RecDescent::_tracefirst($text))
                        if defined $::RD_TRACE;
        push @item, $_tok;
        $item{__ACTION1__}=$_tok;
        

        Parse::RecDescent::_trace(q{>>Matched production: ['second' '(' statement_signal ')']<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    while (!$_matched && !$commit)
    {
        
        Parse::RecDescent::_trace(q{Trying production: [statement_signal]},
                      Parse::RecDescent::_tracefirst($_[1]),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        my $thisprod = $thisrule->{"prods"}[14];
        $text = $_[1];
        my $_savetext;
        @item = (q{timeframe_statement_signal});
        %item = (__RULE__ => q{timeframe_statement_signal});
        my $repcount = 0;


        Parse::RecDescent::_trace(q{Trying subrule: [statement_signal]},
                  Parse::RecDescent::_tracefirst($text),
                  q{timeframe_statement_signal},
                  $tracelevel)
                    if defined $::RD_TRACE;
        if (1) { no strict qw{refs};
        $expectation->is(q{})->at($text);
        unless (defined ($_tok = Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar::statement_signal($thisparser,$text,$repeating,$_noactions,sub { \@arg },undef)))
        {
            
            Parse::RecDescent::_trace(q{<<Didn't match subrule: [statement_signal]>>},
                          Parse::RecDescent::_tracefirst($text),
                          q{timeframe_statement_signal},
                          $tracelevel)
                            if defined $::RD_TRACE;
            $expectation->failed();
            last;
        }
        Parse::RecDescent::_trace(q{>>Matched subrule: [statement_signal]<< (return value: [}
                    . $_tok . q{]},

                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $item{q{statement_signal}} = $_tok;
        push @item, $_tok;
        
        }

        Parse::RecDescent::_trace(q{>>Matched production: [statement_signal]<<},
                      Parse::RecDescent::_tracefirst($text),
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;



        $_matched = 1;
        last;
    }


    unless ( $_matched || defined($score) )
    {
        

        $_[1] = $text;  # NOT SURE THIS IS NEEDED
        Parse::RecDescent::_trace(q{<<Didn't match rule>>},
                     Parse::RecDescent::_tracefirst($_[1]),
                     q{timeframe_statement_signal},
                     $tracelevel)
                    if defined $::RD_TRACE;
        return undef;
    }
    if (!defined($return) && defined($score))
    {
        Parse::RecDescent::_trace(q{>>Accepted scored production<<}, "",
                      q{timeframe_statement_signal},
                      $tracelevel)
                        if defined $::RD_TRACE;
        $return = $score_return;
    }
    splice @{$thisparser->{errors}}, $err_at;
    $return = $item[$#item] unless defined $return;
    if (defined $::RD_TRACE)
    {
        Parse::RecDescent::_trace(q{>>Matched rule<< (return value: [} .
                      $return . q{])}, "",
                      q{timeframe_statement_signal},
                      $tracelevel);
        Parse::RecDescent::_trace(q{(consumed: [} .
                      Parse::RecDescent::_tracemax(substr($_[1],0,-length($text))) . q{])},
                      Parse::RecDescent::_tracefirst($text),
                      , q{timeframe_statement_signal},
                      $tracelevel)
    }
    $_[1] = $text;
    return $return;
}
}
package Finance::HostedTrader::ExpressionParser::Grammar; sub new { my $self = bless( {
                 '_AUTOACTION' => undef,
                 '_AUTOTREE' => undef,
                 '_check' => {
                               'itempos' => '',
                               'prevcolumn' => '',
                               'prevline' => '',
                               'prevoffset' => '',
                               'thiscolumn' => '',
                               'thisoffset' => ''
                             },
                 'localvars' => '',
                 'namespace' => 'Parse::RecDescent::Finance::HostedTrader::ExpressionParser::Grammar',
                 'rules' => {
                              'boolop' => bless( {
                                                   'calls' => [],
                                                   'changed' => 0,
                                                   'impcount' => 0,
                                                   'line' => 29,
                                                   'name' => 'boolop',
                                                   'opcount' => 0,
                                                   'prods' => [
                                                                bless( {
                                                                         'actcount' => 0,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'and\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 29,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => 'and'
                                                                                             }, 'Parse::RecDescent::Literal' )
                                                                                    ],
                                                                         'line' => undef,
                                                                         'number' => 0,
                                                                         'patcount' => 0,
                                                                         'strcount' => 1,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 0,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'or\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 29,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => 'or'
                                                                                             }, 'Parse::RecDescent::Literal' )
                                                                                    ],
                                                                         'line' => 29,
                                                                         'number' => 1,
                                                                         'patcount' => 0,
                                                                         'strcount' => 1,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' )
                                                              ],
                                                   'vars' => ''
                                                 }, 'Parse::RecDescent::Rule' ),
                              'cmp_op' => bless( {
                                                   'calls' => [],
                                                   'changed' => 0,
                                                   'impcount' => 0,
                                                   'line' => 39,
                                                   'name' => 'cmp_op',
                                                   'opcount' => 0,
                                                   'prods' => [
                                                                bless( {
                                                                         'actcount' => 0,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'>=\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 39,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => '>='
                                                                                             }, 'Parse::RecDescent::Literal' )
                                                                                    ],
                                                                         'line' => undef,
                                                                         'number' => 0,
                                                                         'patcount' => 0,
                                                                         'strcount' => 1,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 0,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'>\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 39,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => '>'
                                                                                             }, 'Parse::RecDescent::Literal' )
                                                                                    ],
                                                                         'line' => 39,
                                                                         'number' => 1,
                                                                         'patcount' => 0,
                                                                         'strcount' => 1,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 0,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'<=\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 39,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => '<='
                                                                                             }, 'Parse::RecDescent::Literal' )
                                                                                    ],
                                                                         'line' => 39,
                                                                         'number' => 2,
                                                                         'patcount' => 0,
                                                                         'strcount' => 1,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 0,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'<\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 39,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => '<'
                                                                                             }, 'Parse::RecDescent::Literal' )
                                                                                    ],
                                                                         'line' => 39,
                                                                         'number' => 3,
                                                                         'patcount' => 0,
                                                                         'strcount' => 1,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' )
                                                              ],
                                                   'vars' => ''
                                                 }, 'Parse::RecDescent::Rule' ),
                              'expression' => bless( {
                                                       'calls' => [
                                                                    'term',
                                                                    'math_op',
                                                                    'expression'
                                                                  ],
                                                       'changed' => 0,
                                                       'impcount' => 0,
                                                       'line' => 41,
                                                       'name' => 'expression',
                                                       'opcount' => 0,
                                                       'prods' => [
                                                                    bless( {
                                                                             'actcount' => 1,
                                                                             'dircount' => 0,
                                                                             'error' => undef,
                                                                             'items' => [
                                                                                          bless( {
                                                                                                   'argcode' => undef,
                                                                                                   'implicit' => undef,
                                                                                                   'line' => 41,
                                                                                                   'lookahead' => 0,
                                                                                                   'matchrule' => 0,
                                                                                                   'subrule' => 'term'
                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                          bless( {
                                                                                                   'argcode' => undef,
                                                                                                   'implicit' => undef,
                                                                                                   'line' => 41,
                                                                                                   'lookahead' => 0,
                                                                                                   'matchrule' => 0,
                                                                                                   'subrule' => 'math_op'
                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                          bless( {
                                                                                                   'argcode' => undef,
                                                                                                   'implicit' => undef,
                                                                                                   'line' => 41,
                                                                                                   'lookahead' => 0,
                                                                                                   'matchrule' => 0,
                                                                                                   'subrule' => 'expression'
                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                          bless( {
                                                                                                   'code' => '{"$item[1] $item[2] $item[3]"}',
                                                                                                   'hashname' => '__ACTION1__',
                                                                                                   'line' => 41,
                                                                                                   'lookahead' => 0
                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                        ],
                                                                             'line' => undef,
                                                                             'number' => 0,
                                                                             'patcount' => 0,
                                                                             'strcount' => 0,
                                                                             'uncommit' => undef
                                                                           }, 'Parse::RecDescent::Production' ),
                                                                    bless( {
                                                                             'actcount' => 0,
                                                                             'dircount' => 0,
                                                                             'error' => undef,
                                                                             'items' => [
                                                                                          bless( {
                                                                                                   'argcode' => undef,
                                                                                                   'implicit' => undef,
                                                                                                   'line' => 42,
                                                                                                   'lookahead' => 0,
                                                                                                   'matchrule' => 0,
                                                                                                   'subrule' => 'term'
                                                                                                 }, 'Parse::RecDescent::Subrule' )
                                                                                        ],
                                                                             'line' => 42,
                                                                             'number' => 1,
                                                                             'patcount' => 0,
                                                                             'strcount' => 0,
                                                                             'uncommit' => undef
                                                                           }, 'Parse::RecDescent::Production' )
                                                                  ],
                                                       'vars' => ''
                                                     }, 'Parse::RecDescent::Rule' ),
                              'field' => bless( {
                                                  'calls' => [],
                                                  'changed' => 0,
                                                  'impcount' => 0,
                                                  'line' => 53,
                                                  'name' => 'field',
                                                  'opcount' => 0,
                                                  'prods' => [
                                                               bless( {
                                                                        'actcount' => 0,
                                                                        'dircount' => 0,
                                                                        'error' => undef,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'description' => '\'datetime\'',
                                                                                              'hashname' => '__STRING1__',
                                                                                              'line' => 53,
                                                                                              'lookahead' => 0,
                                                                                              'pattern' => 'datetime'
                                                                                            }, 'Parse::RecDescent::InterpLit' )
                                                                                   ],
                                                                        'line' => undef,
                                                                        'number' => 0,
                                                                        'patcount' => 0,
                                                                        'strcount' => 1,
                                                                        'uncommit' => undef
                                                                      }, 'Parse::RecDescent::Production' ),
                                                               bless( {
                                                                        'actcount' => 0,
                                                                        'dircount' => 0,
                                                                        'error' => undef,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'description' => '\'open\'',
                                                                                              'hashname' => '__STRING1__',
                                                                                              'line' => 53,
                                                                                              'lookahead' => 0,
                                                                                              'pattern' => 'open'
                                                                                            }, 'Parse::RecDescent::InterpLit' )
                                                                                   ],
                                                                        'line' => 53,
                                                                        'number' => 1,
                                                                        'patcount' => 0,
                                                                        'strcount' => 1,
                                                                        'uncommit' => undef
                                                                      }, 'Parse::RecDescent::Production' ),
                                                               bless( {
                                                                        'actcount' => 0,
                                                                        'dircount' => 0,
                                                                        'error' => undef,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'description' => '\'high\'',
                                                                                              'hashname' => '__STRING1__',
                                                                                              'line' => 53,
                                                                                              'lookahead' => 0,
                                                                                              'pattern' => 'high'
                                                                                            }, 'Parse::RecDescent::InterpLit' )
                                                                                   ],
                                                                        'line' => 53,
                                                                        'number' => 2,
                                                                        'patcount' => 0,
                                                                        'strcount' => 1,
                                                                        'uncommit' => undef
                                                                      }, 'Parse::RecDescent::Production' ),
                                                               bless( {
                                                                        'actcount' => 0,
                                                                        'dircount' => 0,
                                                                        'error' => undef,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'description' => '\'low\'',
                                                                                              'hashname' => '__STRING1__',
                                                                                              'line' => 53,
                                                                                              'lookahead' => 0,
                                                                                              'pattern' => 'low'
                                                                                            }, 'Parse::RecDescent::InterpLit' )
                                                                                   ],
                                                                        'line' => 53,
                                                                        'number' => 3,
                                                                        'patcount' => 0,
                                                                        'strcount' => 1,
                                                                        'uncommit' => undef
                                                                      }, 'Parse::RecDescent::Production' ),
                                                               bless( {
                                                                        'actcount' => 0,
                                                                        'dircount' => 0,
                                                                        'error' => undef,
                                                                        'items' => [
                                                                                     bless( {
                                                                                              'description' => '\'close\'',
                                                                                              'hashname' => '__STRING1__',
                                                                                              'line' => 53,
                                                                                              'lookahead' => 0,
                                                                                              'pattern' => 'close'
                                                                                            }, 'Parse::RecDescent::InterpLit' )
                                                                                   ],
                                                                        'line' => 53,
                                                                        'number' => 4,
                                                                        'patcount' => 0,
                                                                        'strcount' => 1,
                                                                        'uncommit' => undef
                                                                      }, 'Parse::RecDescent::Production' )
                                                             ],
                                                  'vars' => ''
                                                }, 'Parse::RecDescent::Rule' ),
                              'function' => bless( {
                                                     'calls' => [
                                                                  'expression',
                                                                  'number'
                                                                ],
                                                     'changed' => 0,
                                                     'impcount' => 0,
                                                     'line' => 55,
                                                     'name' => 'function',
                                                     'opcount' => 0,
                                                     'prods' => [
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'ema(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 56,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'ema('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 56,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 56,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 56,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 56,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_ema($item[2],$item[4]), 4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 56,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => undef,
                                                                           'number' => 0,
                                                                           'patcount' => 0,
                                                                           'strcount' => 3,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'sma(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 57,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'sma('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 57,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 57,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 57,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 57,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_sma($item[2],$item[4]), 4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 57,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 56,
                                                                           'number' => 1,
                                                                           'patcount' => 0,
                                                                           'strcount' => 3,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'rsi(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 58,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'rsi('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 58,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 58,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 58,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 58,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_rsi($item[2],$item[4]), 2)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 58,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 57,
                                                                           'number' => 2,
                                                                           'patcount' => 0,
                                                                           'strcount' => 3,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'max(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 59,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'max('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 59,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 59,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 59,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 59,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "ta_max($item[2],$item[4])" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 59,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 58,
                                                                           'number' => 3,
                                                                           'patcount' => 0,
                                                                           'strcount' => 3,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'min(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 60,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'min('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 60,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 60,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 60,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 60,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "ta_min($item[2],$item[4])" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 60,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 59,
                                                                           'number' => 4,
                                                                           'patcount' => 0,
                                                                           'strcount' => 3,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'tr(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 61,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'tr('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 61,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_tr(high,low,close), 4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 61,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 60,
                                                                           'number' => 5,
                                                                           'patcount' => 0,
                                                                           'strcount' => 2,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'atr(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 62,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'atr('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 62,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 62,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_ema(ta_tr(high,low,close),$item[2]), 4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 62,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 61,
                                                                           'number' => 6,
                                                                           'patcount' => 0,
                                                                           'strcount' => 2,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'previous(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 63,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'previous('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 63,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 63,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 63,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 63,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "ta_previous($item[2],$item[4])" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 63,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 62,
                                                                           'number' => 7,
                                                                           'patcount' => 0,
                                                                           'strcount' => 3,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'bolhigh(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 64,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'bolhigh('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 64,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 64,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 64,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 64,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 64,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING4__',
                                                                                                 'line' => 64,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_sma($item[2],$item[4]) + $item[6]*ta_stddevp($item[2], $item[4]), 4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 64,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 63,
                                                                           'number' => 8,
                                                                           'patcount' => 0,
                                                                           'strcount' => 4,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'bollow(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 65,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'bollow('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 65,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 65,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 65,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 65,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 65,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING4__',
                                                                                                 'line' => 65,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_sma($item[2],$item[4]) - $item[6]*ta_stddevp($item[2], $item[4]), 4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 65,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 64,
                                                                           'number' => 9,
                                                                           'patcount' => 0,
                                                                           'strcount' => 4,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'trend(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 66,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'trend('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 66,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 66,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 66,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 66,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(($item[2] - ta_sma($item[2],$item[4])) / (SQRT(ta_sum(POW($item[2] - ta_sma($item[2], $item[4]), 2), $item[4])/$item[4])), 2)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 66,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 65,
                                                                           'number' => 10,
                                                                           'patcount' => 0,
                                                                           'strcount' => 3,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'macd(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'macd('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING4__',
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING5__',
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]), 4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 67,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 66,
                                                                           'number' => 11,
                                                                           'patcount' => 0,
                                                                           'strcount' => 5,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'macdsig(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'macdsig('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING4__',
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING5__',
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(ta_ema(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]),$item[8]),4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 68,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 67,
                                                                           'number' => 12,
                                                                           'patcount' => 0,
                                                                           'strcount' => 5,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'macddiff(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'macddiff('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING3__',
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\',\'',
                                                                                                 'hashname' => '__STRING4__',
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ','
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'number'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING5__',
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round((ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6])) - (ta_ema(ta_ema($item[2],$item[4]) - ta_ema($item[2],$item[6]),$item[8])),4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 69,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 68,
                                                                           'number' => 13,
                                                                           'patcount' => 0,
                                                                           'strcount' => 5,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'abs(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 70,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'abs('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 70,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 70,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "round(abs($item[2]), 4)" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 70,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 69,
                                                                           'number' => 14,
                                                                           'patcount' => 0,
                                                                           'strcount' => 2,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'weekday(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 71,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'weekday('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 71,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 71,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "weekday($item[2])" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 71,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 70,
                                                                           'number' => 15,
                                                                           'patcount' => 0,
                                                                           'strcount' => 2,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' ),
                                                                  bless( {
                                                                           'actcount' => 1,
                                                                           'dircount' => 0,
                                                                           'error' => undef,
                                                                           'items' => [
                                                                                        bless( {
                                                                                                 'description' => '\'dayname(\'',
                                                                                                 'hashname' => '__STRING1__',
                                                                                                 'line' => 72,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => 'dayname('
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'argcode' => undef,
                                                                                                 'implicit' => undef,
                                                                                                 'line' => 72,
                                                                                                 'lookahead' => 0,
                                                                                                 'matchrule' => 0,
                                                                                                 'subrule' => 'expression'
                                                                                               }, 'Parse::RecDescent::Subrule' ),
                                                                                        bless( {
                                                                                                 'description' => '\')\'',
                                                                                                 'hashname' => '__STRING2__',
                                                                                                 'line' => 72,
                                                                                                 'lookahead' => 0,
                                                                                                 'pattern' => ')'
                                                                                               }, 'Parse::RecDescent::Literal' ),
                                                                                        bless( {
                                                                                                 'code' => '{ "dayname($item[2])" }',
                                                                                                 'hashname' => '__ACTION1__',
                                                                                                 'line' => 72,
                                                                                                 'lookahead' => 0
                                                                                               }, 'Parse::RecDescent::Action' )
                                                                                      ],
                                                                           'line' => 71,
                                                                           'number' => 16,
                                                                           'patcount' => 0,
                                                                           'strcount' => 2,
                                                                           'uncommit' => undef
                                                                         }, 'Parse::RecDescent::Production' )
                                                                ],
                                                     'vars' => ''
                                                   }, 'Parse::RecDescent::Rule' ),
                              'math_op' => bless( {
                                                    'calls' => [],
                                                    'changed' => 0,
                                                    'impcount' => 0,
                                                    'line' => 44,
                                                    'name' => 'math_op',
                                                    'opcount' => 0,
                                                    'prods' => [
                                                                 bless( {
                                                                          'actcount' => 0,
                                                                          'dircount' => 0,
                                                                          'error' => undef,
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'description' => '\'+\'',
                                                                                                'hashname' => '__STRING1__',
                                                                                                'line' => 44,
                                                                                                'lookahead' => 0,
                                                                                                'pattern' => '+'
                                                                                              }, 'Parse::RecDescent::Literal' )
                                                                                     ],
                                                                          'line' => undef,
                                                                          'number' => 0,
                                                                          'patcount' => 0,
                                                                          'strcount' => 1,
                                                                          'uncommit' => undef
                                                                        }, 'Parse::RecDescent::Production' ),
                                                                 bless( {
                                                                          'actcount' => 0,
                                                                          'dircount' => 0,
                                                                          'error' => undef,
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'description' => '\'-\'',
                                                                                                'hashname' => '__STRING1__',
                                                                                                'line' => 44,
                                                                                                'lookahead' => 0,
                                                                                                'pattern' => '-'
                                                                                              }, 'Parse::RecDescent::Literal' )
                                                                                     ],
                                                                          'line' => 44,
                                                                          'number' => 1,
                                                                          'patcount' => 0,
                                                                          'strcount' => 1,
                                                                          'uncommit' => undef
                                                                        }, 'Parse::RecDescent::Production' ),
                                                                 bless( {
                                                                          'actcount' => 0,
                                                                          'dircount' => 0,
                                                                          'error' => undef,
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'description' => '\'*\'',
                                                                                                'hashname' => '__STRING1__',
                                                                                                'line' => 44,
                                                                                                'lookahead' => 0,
                                                                                                'pattern' => '*'
                                                                                              }, 'Parse::RecDescent::Literal' )
                                                                                     ],
                                                                          'line' => 44,
                                                                          'number' => 2,
                                                                          'patcount' => 0,
                                                                          'strcount' => 1,
                                                                          'uncommit' => undef
                                                                        }, 'Parse::RecDescent::Production' ),
                                                                 bless( {
                                                                          'actcount' => 0,
                                                                          'dircount' => 0,
                                                                          'error' => undef,
                                                                          'items' => [
                                                                                       bless( {
                                                                                                'description' => '\'/\'',
                                                                                                'hashname' => '__STRING1__',
                                                                                                'line' => 44,
                                                                                                'lookahead' => 0,
                                                                                                'pattern' => '/'
                                                                                              }, 'Parse::RecDescent::Literal' )
                                                                                     ],
                                                                          'line' => 44,
                                                                          'number' => 3,
                                                                          'patcount' => 0,
                                                                          'strcount' => 1,
                                                                          'uncommit' => undef
                                                                        }, 'Parse::RecDescent::Production' )
                                                               ],
                                                    'vars' => ''
                                                  }, 'Parse::RecDescent::Rule' ),
                              'number' => bless( {
                                                   'calls' => [],
                                                   'changed' => 0,
                                                   'impcount' => 0,
                                                   'line' => 51,
                                                   'name' => 'number',
                                                   'opcount' => 0,
                                                   'prods' => [
                                                                bless( {
                                                                         'actcount' => 0,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '/-?\\\\d+(\\\\.\\\\d+)?/',
                                                                                               'hashname' => '__PATTERN1__',
                                                                                               'ldelim' => '/',
                                                                                               'line' => 51,
                                                                                               'lookahead' => 0,
                                                                                               'mod' => '',
                                                                                               'pattern' => '-?\\d+(\\.\\d+)?',
                                                                                               'rdelim' => '/'
                                                                                             }, 'Parse::RecDescent::Token' )
                                                                                    ],
                                                                         'line' => undef,
                                                                         'number' => 0,
                                                                         'patcount' => 1,
                                                                         'strcount' => 0,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' )
                                                              ],
                                                   'vars' => ''
                                                 }, 'Parse::RecDescent::Rule' ),
                              'recursive_timeframe_statement_signal' => bless( {
                                                                                 'calls' => [
                                                                                              'timeframe_statement_signal',
                                                                                              'boolop'
                                                                                            ],
                                                                                 'changed' => 0,
                                                                                 'impcount' => 0,
                                                                                 'line' => 7,
                                                                                 'name' => 'recursive_timeframe_statement_signal',
                                                                                 'opcount' => 0,
                                                                                 'prods' => [
                                                                                              bless( {
                                                                                                       'actcount' => 1,
                                                                                                       'dircount' => 1,
                                                                                                       'error' => undef,
                                                                                                       'items' => [
                                                                                                                    bless( {
                                                                                                                             'expected' => '<leftop: timeframe_statement_signal boolop timeframe_statement_signal>',
                                                                                                                             'hashname' => '__DIRECTIVE1__',
                                                                                                                             'leftarg' => bless( {
                                                                                                                                                   'argcode' => undef,
                                                                                                                                                   'implicit' => undef,
                                                                                                                                                   'line' => 7,
                                                                                                                                                   'lookahead' => 0,
                                                                                                                                                   'matchrule' => 0,
                                                                                                                                                   'subrule' => 'timeframe_statement_signal'
                                                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                                             'max' => 100000000,
                                                                                                                             'min' => 1,
                                                                                                                             'name' => '',
                                                                                                                             'op' => bless( {
                                                                                                                                              'argcode' => undef,
                                                                                                                                              'implicit' => undef,
                                                                                                                                              'line' => 7,
                                                                                                                                              'lookahead' => 0,
                                                                                                                                              'matchrule' => 0,
                                                                                                                                              'subrule' => 'boolop'
                                                                                                                                            }, 'Parse::RecDescent::Subrule' ),
                                                                                                                             'rightarg' => bless( {
                                                                                                                                                    'argcode' => undef,
                                                                                                                                                    'implicit' => undef,
                                                                                                                                                    'line' => 7,
                                                                                                                                                    'lookahead' => 0,
                                                                                                                                                    'matchrule' => 0,
                                                                                                                                                    'subrule' => 'timeframe_statement_signal'
                                                                                                                                                  }, 'Parse::RecDescent::Subrule' ),
                                                                                                                             'type' => 'leftop'
                                                                                                                           }, 'Parse::RecDescent::Operator' ),
                                                                                                                    bless( {
                                                                                                                             'code' => '{ $item[1] }',
                                                                                                                             'hashname' => '__ACTION1__',
                                                                                                                             'line' => 7,
                                                                                                                             'lookahead' => 0
                                                                                                                           }, 'Parse::RecDescent::Action' )
                                                                                                                  ],
                                                                                                       'line' => undef,
                                                                                                       'number' => 0,
                                                                                                       'op' => [],
                                                                                                       'patcount' => 0,
                                                                                                       'strcount' => 0,
                                                                                                       'uncommit' => undef
                                                                                                     }, 'Parse::RecDescent::Production' )
                                                                                            ],
                                                                                 'vars' => ''
                                                                               }, 'Parse::RecDescent::Rule' ),
                              'signal' => bless( {
                                                   'calls' => [
                                                                'expression',
                                                                'number',
                                                                'cmp_op'
                                                              ],
                                                   'changed' => 0,
                                                   'impcount' => 0,
                                                   'line' => 31,
                                                   'name' => 'signal',
                                                   'opcount' => 0,
                                                   'prods' => [
                                                                bless( {
                                                                         'actcount' => 1,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'crossoverup\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 32,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => 'crossoverup'
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'description' => '\'(\'',
                                                                                               'hashname' => '__STRING2__',
                                                                                               'line' => 32,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => '('
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 32,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'description' => '\',\'',
                                                                                               'hashname' => '__STRING3__',
                                                                                               'line' => 32,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => ','
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 32,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'number'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'description' => '\')\'',
                                                                                               'hashname' => '__STRING4__',
                                                                                               'line' => 32,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => ')'
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'code' => '{ my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverup","ta_previous($item[3],1)", $item[5], $item[3], $item[5]); $key }',
                                                                                               'hashname' => '__ACTION1__',
                                                                                               'line' => 32,
                                                                                               'lookahead' => 0
                                                                                             }, 'Parse::RecDescent::Action' )
                                                                                    ],
                                                                         'line' => undef,
                                                                         'number' => 0,
                                                                         'patcount' => 0,
                                                                         'strcount' => 4,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 1,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'crossoverup\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 33,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => 'crossoverup'
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'description' => '\'(\'',
                                                                                               'hashname' => '__STRING2__',
                                                                                               'line' => 33,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => '('
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 33,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'description' => '\',\'',
                                                                                               'hashname' => '__STRING3__',
                                                                                               'line' => 33,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => ','
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 33,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'description' => '\')\'',
                                                                                               'hashname' => '__STRING4__',
                                                                                               'line' => 33,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => ')'
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'code' => '{ my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverup","ta_previous($item[3],1)", "ta_previous($item[5],1)", $item[3], $item[5]); $key }',
                                                                                               'hashname' => '__ACTION1__',
                                                                                               'line' => 33,
                                                                                               'lookahead' => 0
                                                                                             }, 'Parse::RecDescent::Action' )
                                                                                    ],
                                                                         'line' => 33,
                                                                         'number' => 1,
                                                                         'patcount' => 0,
                                                                         'strcount' => 4,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 1,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'crossoverdown\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 34,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => 'crossoverdown'
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'description' => '\'(\'',
                                                                                               'hashname' => '__STRING2__',
                                                                                               'line' => 34,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => '('
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 34,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'description' => '\',\'',
                                                                                               'hashname' => '__STRING3__',
                                                                                               'line' => 34,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => ','
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 34,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'number'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'description' => '\')\'',
                                                                                               'hashname' => '__STRING4__',
                                                                                               'line' => 34,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => ')'
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'code' => '{ my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverdown","ta_previous($item[3],1)", $item[5], $item[3], $item[5]); $key }',
                                                                                               'hashname' => '__ACTION1__',
                                                                                               'line' => 34,
                                                                                               'lookahead' => 0
                                                                                             }, 'Parse::RecDescent::Action' )
                                                                                    ],
                                                                         'line' => 34,
                                                                         'number' => 2,
                                                                         'patcount' => 0,
                                                                         'strcount' => 4,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 1,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'description' => '\'crossoverdown\'',
                                                                                               'hashname' => '__STRING1__',
                                                                                               'line' => 35,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => 'crossoverdown'
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'description' => '\'(\'',
                                                                                               'hashname' => '__STRING2__',
                                                                                               'line' => 35,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => '('
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 35,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'description' => '\',\'',
                                                                                               'hashname' => '__STRING3__',
                                                                                               'line' => 35,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => ','
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 35,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'description' => '\')\'',
                                                                                               'hashname' => '__STRING4__',
                                                                                               'line' => 35,
                                                                                               'lookahead' => 0,
                                                                                               'pattern' => ')'
                                                                                             }, 'Parse::RecDescent::Literal' ),
                                                                                      bless( {
                                                                                               'code' => '{ my $key = Finance::HostedTrader::ExpressionParser::getID("crossoverdown","ta_previous($item[3],1)", "ta_previous($item[5],1)", $item[3], $item[5]); $key }',
                                                                                               'hashname' => '__ACTION1__',
                                                                                               'line' => 35,
                                                                                               'lookahead' => 0
                                                                                             }, 'Parse::RecDescent::Action' )
                                                                                    ],
                                                                         'line' => 35,
                                                                         'number' => 3,
                                                                         'patcount' => 0,
                                                                         'strcount' => 4,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 1,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 36,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 36,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'cmp_op'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 36,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                      bless( {
                                                                                               'code' => '{ my $key = Finance::HostedTrader::ExpressionParser::getID("cmpop$item[2]",$item[1],$item[3]); $key }',
                                                                                               'hashname' => '__ACTION1__',
                                                                                               'line' => 36,
                                                                                               'lookahead' => 0
                                                                                             }, 'Parse::RecDescent::Action' )
                                                                                    ],
                                                                         'line' => 36,
                                                                         'number' => 4,
                                                                         'patcount' => 0,
                                                                         'strcount' => 0,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' ),
                                                                bless( {
                                                                         'actcount' => 0,
                                                                         'dircount' => 0,
                                                                         'error' => undef,
                                                                         'items' => [
                                                                                      bless( {
                                                                                               'argcode' => undef,
                                                                                               'implicit' => undef,
                                                                                               'line' => 37,
                                                                                               'lookahead' => 0,
                                                                                               'matchrule' => 0,
                                                                                               'subrule' => 'expression'
                                                                                             }, 'Parse::RecDescent::Subrule' )
                                                                                    ],
                                                                         'line' => 37,
                                                                         'number' => 5,
                                                                         'patcount' => 0,
                                                                         'strcount' => 0,
                                                                         'uncommit' => undef
                                                                       }, 'Parse::RecDescent::Production' )
                                                              ],
                                                   'vars' => ''
                                                 }, 'Parse::RecDescent::Rule' ),
                              'start_indicator' => bless( {
                                                            'calls' => [
                                                                         'statement_indicator'
                                                                       ],
                                                            'changed' => 0,
                                                            'impcount' => 0,
                                                            'line' => 1,
                                                            'name' => 'start_indicator',
                                                            'opcount' => 0,
                                                            'prods' => [
                                                                         bless( {
                                                                                  'actcount' => 1,
                                                                                  'dircount' => 0,
                                                                                  'error' => undef,
                                                                                  'items' => [
                                                                                               bless( {
                                                                                                        'argcode' => undef,
                                                                                                        'implicit' => undef,
                                                                                                        'line' => 1,
                                                                                                        'lookahead' => 0,
                                                                                                        'matchrule' => 0,
                                                                                                        'subrule' => 'statement_indicator'
                                                                                                      }, 'Parse::RecDescent::Subrule' ),
                                                                                               bless( {
                                                                                                        'description' => '/\\\\Z/',
                                                                                                        'hashname' => '__PATTERN1__',
                                                                                                        'ldelim' => '/',
                                                                                                        'line' => 1,
                                                                                                        'lookahead' => 0,
                                                                                                        'mod' => '',
                                                                                                        'pattern' => '\\Z',
                                                                                                        'rdelim' => '/'
                                                                                                      }, 'Parse::RecDescent::Token' ),
                                                                                               bless( {
                                                                                                        'code' => '{$item[1]}',
                                                                                                        'hashname' => '__ACTION1__',
                                                                                                        'line' => 1,
                                                                                                        'lookahead' => 0
                                                                                                      }, 'Parse::RecDescent::Action' )
                                                                                             ],
                                                                                  'line' => undef,
                                                                                  'number' => 0,
                                                                                  'patcount' => 1,
                                                                                  'strcount' => 0,
                                                                                  'uncommit' => undef
                                                                                }, 'Parse::RecDescent::Production' )
                                                                       ],
                                                            'vars' => ''
                                                          }, 'Parse::RecDescent::Rule' ),
                              'start_signal' => bless( {
                                                         'calls' => [
                                                                      'recursive_timeframe_statement_signal'
                                                                    ],
                                                         'changed' => 0,
                                                         'impcount' => 0,
                                                         'line' => 3,
                                                         'name' => 'start_signal',
                                                         'opcount' => 0,
                                                         'prods' => [
                                                                      bless( {
                                                                               'actcount' => 1,
                                                                               'dircount' => 0,
                                                                               'error' => undef,
                                                                               'items' => [
                                                                                            bless( {
                                                                                                     'argcode' => undef,
                                                                                                     'implicit' => undef,
                                                                                                     'line' => 3,
                                                                                                     'lookahead' => 0,
                                                                                                     'matchrule' => 0,
                                                                                                     'subrule' => 'recursive_timeframe_statement_signal'
                                                                                                   }, 'Parse::RecDescent::Subrule' ),
                                                                                            bless( {
                                                                                                     'description' => '/\\\\Z/',
                                                                                                     'hashname' => '__PATTERN1__',
                                                                                                     'ldelim' => '/',
                                                                                                     'line' => 3,
                                                                                                     'lookahead' => 0,
                                                                                                     'mod' => '',
                                                                                                     'pattern' => '\\Z',
                                                                                                     'rdelim' => '/'
                                                                                                   }, 'Parse::RecDescent::Token' ),
                                                                                            bless( {
                                                                                                     'code' => '{$item[1]}',
                                                                                                     'hashname' => '__ACTION1__',
                                                                                                     'line' => 3,
                                                                                                     'lookahead' => 0
                                                                                                   }, 'Parse::RecDescent::Action' )
                                                                                          ],
                                                                               'line' => undef,
                                                                               'number' => 0,
                                                                               'patcount' => 1,
                                                                               'strcount' => 0,
                                                                               'uncommit' => undef
                                                                             }, 'Parse::RecDescent::Production' )
                                                                    ],
                                                         'vars' => ''
                                                       }, 'Parse::RecDescent::Rule' ),
                              'statement' => bless( {
                                                      'calls' => [
                                                                   'statement_indicator',
                                                                   'statement_signal'
                                                                 ],
                                                      'changed' => 0,
                                                      'impcount' => 0,
                                                      'line' => 27,
                                                      'name' => 'statement',
                                                      'opcount' => 0,
                                                      'prods' => [
                                                                   bless( {
                                                                            'actcount' => 0,
                                                                            'dircount' => 0,
                                                                            'error' => undef,
                                                                            'items' => [
                                                                                         bless( {
                                                                                                  'argcode' => undef,
                                                                                                  'implicit' => undef,
                                                                                                  'line' => 27,
                                                                                                  'lookahead' => 0,
                                                                                                  'matchrule' => 0,
                                                                                                  'subrule' => 'statement_indicator'
                                                                                                }, 'Parse::RecDescent::Subrule' )
                                                                                       ],
                                                                            'line' => undef,
                                                                            'number' => 0,
                                                                            'patcount' => 0,
                                                                            'strcount' => 0,
                                                                            'uncommit' => undef
                                                                          }, 'Parse::RecDescent::Production' ),
                                                                   bless( {
                                                                            'actcount' => 0,
                                                                            'dircount' => 0,
                                                                            'error' => undef,
                                                                            'items' => [
                                                                                         bless( {
                                                                                                  'argcode' => undef,
                                                                                                  'implicit' => undef,
                                                                                                  'line' => 27,
                                                                                                  'lookahead' => 0,
                                                                                                  'matchrule' => 0,
                                                                                                  'subrule' => 'statement_signal'
                                                                                                }, 'Parse::RecDescent::Subrule' )
                                                                                       ],
                                                                            'line' => 27,
                                                                            'number' => 1,
                                                                            'patcount' => 0,
                                                                            'strcount' => 0,
                                                                            'uncommit' => undef
                                                                          }, 'Parse::RecDescent::Production' )
                                                                 ],
                                                      'vars' => ''
                                                    }, 'Parse::RecDescent::Rule' ),
                              'statement_indicator' => bless( {
                                                                'calls' => [
                                                                             'expression'
                                                                           ],
                                                                'changed' => 0,
                                                                'impcount' => 0,
                                                                'line' => 5,
                                                                'name' => 'statement_indicator',
                                                                'opcount' => 0,
                                                                'prods' => [
                                                                             bless( {
                                                                                      'actcount' => 1,
                                                                                      'dircount' => 1,
                                                                                      'error' => undef,
                                                                                      'items' => [
                                                                                                   bless( {
                                                                                                            'expected' => '<leftop: expression /,/ expression>',
                                                                                                            'hashname' => '__DIRECTIVE1__',
                                                                                                            'leftarg' => bless( {
                                                                                                                                  'argcode' => undef,
                                                                                                                                  'implicit' => undef,
                                                                                                                                  'line' => 5,
                                                                                                                                  'lookahead' => 0,
                                                                                                                                  'matchrule' => 0,
                                                                                                                                  'subrule' => 'expression'
                                                                                                                                }, 'Parse::RecDescent::Subrule' ),
                                                                                                            'max' => 100000000,
                                                                                                            'min' => 1,
                                                                                                            'name' => '\'expression(s)\'',
                                                                                                            'op' => bless( {
                                                                                                                             'description' => '/,/',
                                                                                                                             'hashname' => '__PATTERN1__',
                                                                                                                             'ldelim' => '/',
                                                                                                                             'line' => 5,
                                                                                                                             'lookahead' => 0,
                                                                                                                             'mod' => '',
                                                                                                                             'pattern' => ',',
                                                                                                                             'rdelim' => '/'
                                                                                                                           }, 'Parse::RecDescent::Token' ),
                                                                                                            'rightarg' => bless( {
                                                                                                                                   'argcode' => undef,
                                                                                                                                   'implicit' => undef,
                                                                                                                                   'line' => 5,
                                                                                                                                   'lookahead' => 0,
                                                                                                                                   'matchrule' => 0,
                                                                                                                                   'subrule' => 'expression'
                                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                            'type' => 'leftop'
                                                                                                          }, 'Parse::RecDescent::Operator' ),
                                                                                                   bless( {
                                                                                                            'code' => '{join(\',\', map { (/^[0-9]/ ? $_ : "$_") } @{$item[1]})}',
                                                                                                            'hashname' => '__ACTION1__',
                                                                                                            'line' => 5,
                                                                                                            'lookahead' => 0
                                                                                                          }, 'Parse::RecDescent::Action' )
                                                                                                 ],
                                                                                      'line' => undef,
                                                                                      'number' => 0,
                                                                                      'op' => [],
                                                                                      'patcount' => 1,
                                                                                      'strcount' => 0,
                                                                                      'uncommit' => undef
                                                                                    }, 'Parse::RecDescent::Production' )
                                                                           ],
                                                                'vars' => ''
                                                              }, 'Parse::RecDescent::Rule' ),
                              'statement_signal' => bless( {
                                                             'calls' => [
                                                                          'signal',
                                                                          'boolop'
                                                                        ],
                                                             'changed' => 0,
                                                             'impcount' => 0,
                                                             'line' => 25,
                                                             'name' => 'statement_signal',
                                                             'opcount' => 0,
                                                             'prods' => [
                                                                          bless( {
                                                                                   'actcount' => 1,
                                                                                   'dircount' => 1,
                                                                                   'error' => undef,
                                                                                   'items' => [
                                                                                                bless( {
                                                                                                         'expected' => '<leftop: signal boolop signal>',
                                                                                                         'hashname' => '__DIRECTIVE1__',
                                                                                                         'leftarg' => bless( {
                                                                                                                               'argcode' => undef,
                                                                                                                               'implicit' => undef,
                                                                                                                               'line' => 25,
                                                                                                                               'lookahead' => 0,
                                                                                                                               'matchrule' => 0,
                                                                                                                               'subrule' => 'signal'
                                                                                                                             }, 'Parse::RecDescent::Subrule' ),
                                                                                                         'max' => 100000000,
                                                                                                         'min' => 1,
                                                                                                         'name' => '',
                                                                                                         'op' => bless( {
                                                                                                                          'argcode' => undef,
                                                                                                                          'implicit' => undef,
                                                                                                                          'line' => 25,
                                                                                                                          'lookahead' => 0,
                                                                                                                          'matchrule' => 0,
                                                                                                                          'subrule' => 'boolop'
                                                                                                                        }, 'Parse::RecDescent::Subrule' ),
                                                                                                         'rightarg' => bless( {
                                                                                                                                'argcode' => undef,
                                                                                                                                'implicit' => undef,
                                                                                                                                'line' => 25,
                                                                                                                                'lookahead' => 0,
                                                                                                                                'matchrule' => 0,
                                                                                                                                'subrule' => 'signal'
                                                                                                                              }, 'Parse::RecDescent::Subrule' ),
                                                                                                         'type' => 'leftop'
                                                                                                       }, 'Parse::RecDescent::Operator' ),
                                                                                                bless( {
                                                                                                         'code' => '{ $item[1] }',
                                                                                                         'hashname' => '__ACTION1__',
                                                                                                         'line' => 25,
                                                                                                         'lookahead' => 0
                                                                                                       }, 'Parse::RecDescent::Action' )
                                                                                              ],
                                                                                   'line' => undef,
                                                                                   'number' => 0,
                                                                                   'op' => [],
                                                                                   'patcount' => 0,
                                                                                   'strcount' => 0,
                                                                                   'uncommit' => undef
                                                                                 }, 'Parse::RecDescent::Production' )
                                                                        ],
                                                             'vars' => ''
                                                           }, 'Parse::RecDescent::Rule' ),
                              'term' => bless( {
                                                 'calls' => [
                                                              'number',
                                                              'field',
                                                              'function',
                                                              'statement'
                                                            ],
                                                 'changed' => 0,
                                                 'impcount' => 0,
                                                 'line' => 46,
                                                 'name' => 'term',
                                                 'opcount' => 0,
                                                 'prods' => [
                                                              bless( {
                                                                       'actcount' => 0,
                                                                       'dircount' => 0,
                                                                       'error' => undef,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'argcode' => undef,
                                                                                             'implicit' => undef,
                                                                                             'line' => 46,
                                                                                             'lookahead' => 0,
                                                                                             'matchrule' => 0,
                                                                                             'subrule' => 'number'
                                                                                           }, 'Parse::RecDescent::Subrule' )
                                                                                  ],
                                                                       'line' => undef,
                                                                       'number' => 0,
                                                                       'patcount' => 0,
                                                                       'strcount' => 0,
                                                                       'uncommit' => undef
                                                                     }, 'Parse::RecDescent::Production' ),
                                                              bless( {
                                                                       'actcount' => 0,
                                                                       'dircount' => 0,
                                                                       'error' => undef,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'argcode' => undef,
                                                                                             'implicit' => undef,
                                                                                             'line' => 47,
                                                                                             'lookahead' => 0,
                                                                                             'matchrule' => 0,
                                                                                             'subrule' => 'field'
                                                                                           }, 'Parse::RecDescent::Subrule' )
                                                                                  ],
                                                                       'line' => 47,
                                                                       'number' => 1,
                                                                       'patcount' => 0,
                                                                       'strcount' => 0,
                                                                       'uncommit' => undef
                                                                     }, 'Parse::RecDescent::Production' ),
                                                              bless( {
                                                                       'actcount' => 0,
                                                                       'dircount' => 0,
                                                                       'error' => undef,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'argcode' => undef,
                                                                                             'implicit' => undef,
                                                                                             'line' => 48,
                                                                                             'lookahead' => 0,
                                                                                             'matchrule' => 0,
                                                                                             'subrule' => 'function'
                                                                                           }, 'Parse::RecDescent::Subrule' )
                                                                                  ],
                                                                       'line' => 48,
                                                                       'number' => 2,
                                                                       'patcount' => 0,
                                                                       'strcount' => 0,
                                                                       'uncommit' => undef
                                                                     }, 'Parse::RecDescent::Production' ),
                                                              bless( {
                                                                       'actcount' => 1,
                                                                       'dircount' => 0,
                                                                       'error' => undef,
                                                                       'items' => [
                                                                                    bless( {
                                                                                             'description' => '\'(\'',
                                                                                             'hashname' => '__STRING1__',
                                                                                             'line' => 49,
                                                                                             'lookahead' => 0,
                                                                                             'pattern' => '('
                                                                                           }, 'Parse::RecDescent::Literal' ),
                                                                                    bless( {
                                                                                             'argcode' => undef,
                                                                                             'implicit' => undef,
                                                                                             'line' => 49,
                                                                                             'lookahead' => 0,
                                                                                             'matchrule' => 0,
                                                                                             'subrule' => 'statement'
                                                                                           }, 'Parse::RecDescent::Subrule' ),
                                                                                    bless( {
                                                                                             'description' => '\')\'',
                                                                                             'hashname' => '__STRING2__',
                                                                                             'line' => 49,
                                                                                             'lookahead' => 0,
                                                                                             'pattern' => ')'
                                                                                           }, 'Parse::RecDescent::Literal' ),
                                                                                    bless( {
                                                                                             'code' => '{"($item[2])"}',
                                                                                             'hashname' => '__ACTION1__',
                                                                                             'line' => 49,
                                                                                             'lookahead' => 0
                                                                                           }, 'Parse::RecDescent::Action' )
                                                                                  ],
                                                                       'line' => 49,
                                                                       'number' => 3,
                                                                       'patcount' => 0,
                                                                       'strcount' => 2,
                                                                       'uncommit' => undef
                                                                     }, 'Parse::RecDescent::Production' )
                                                            ],
                                                 'vars' => ''
                                               }, 'Parse::RecDescent::Rule' ),
                              'timeframe_statement_signal' => bless( {
                                                                       'calls' => [
                                                                                    'statement_signal'
                                                                                  ],
                                                                       'changed' => 0,
                                                                       'impcount' => 0,
                                                                       'line' => 9,
                                                                       'name' => 'timeframe_statement_signal',
                                                                       'opcount' => 0,
                                                                       'prods' => [
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'day\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 9,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => 'day'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 9,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 9,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 9,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 86400); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 9,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => undef,
                                                                                             'number' => 0,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'4hour\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 10,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '4hour'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 10,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 10,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 10,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 14400); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 10,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 10,
                                                                                             'number' => 1,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'3hour\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 11,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '3hour'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 11,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 11,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 11,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 10800); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 11,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 11,
                                                                                             'number' => 2,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'2hour\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 12,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '2hour'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 12,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 12,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 12,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 7200); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 12,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 12,
                                                                                             'number' => 3,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'hour\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 13,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => 'hour'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 13,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 13,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 13,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 3600); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 13,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 13,
                                                                                             'number' => 4,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'30minute\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 14,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '30minute'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 14,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 14,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 14,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 1800); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 14,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 14,
                                                                                             'number' => 5,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'15minute\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 15,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '15minute'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 15,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 15,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 15,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 900); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 15,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 15,
                                                                                             'number' => 6,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'5minute\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 16,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '5minute'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 16,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 16,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 16,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 300); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 16,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 16,
                                                                                             'number' => 7,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'2minute\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 17,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '2minute'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 17,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 17,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 17,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 120); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 17,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 17,
                                                                                             'number' => 8,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'minute\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 18,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => 'minute'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 18,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 18,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 18,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 60); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 18,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 18,
                                                                                             'number' => 9,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'30second\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 19,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '30second'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 19,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 19,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 19,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 30); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 19,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 19,
                                                                                             'number' => 10,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'15second\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 20,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '15second'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 20,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 20,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 20,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 15); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 20,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 20,
                                                                                             'number' => 11,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'5second\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 21,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '5second'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 21,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 21,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 21,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 5); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 21,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 21,
                                                                                             'number' => 12,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 1,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'description' => '\'second\'',
                                                                                                                   'hashname' => '__STRING1__',
                                                                                                                   'line' => 22,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => 'second'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\'(\'',
                                                                                                                   'hashname' => '__STRING2__',
                                                                                                                   'line' => 22,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => '('
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 22,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' ),
                                                                                                          bless( {
                                                                                                                   'description' => '\')\'',
                                                                                                                   'hashname' => '__STRING3__',
                                                                                                                   'line' => 22,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'pattern' => ')'
                                                                                                                 }, 'Parse::RecDescent::Literal' ),
                                                                                                          bless( {
                                                                                                                   'code' => '{ Finance::HostedTrader::ExpressionParser::setSignalTimeframe($item[3], 1); $item[3] }',
                                                                                                                   'hashname' => '__ACTION1__',
                                                                                                                   'line' => 22,
                                                                                                                   'lookahead' => 0
                                                                                                                 }, 'Parse::RecDescent::Action' )
                                                                                                        ],
                                                                                             'line' => 22,
                                                                                             'number' => 13,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 3,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' ),
                                                                                    bless( {
                                                                                             'actcount' => 0,
                                                                                             'dircount' => 0,
                                                                                             'error' => undef,
                                                                                             'items' => [
                                                                                                          bless( {
                                                                                                                   'argcode' => undef,
                                                                                                                   'implicit' => undef,
                                                                                                                   'line' => 23,
                                                                                                                   'lookahead' => 0,
                                                                                                                   'matchrule' => 0,
                                                                                                                   'subrule' => 'statement_signal'
                                                                                                                 }, 'Parse::RecDescent::Subrule' )
                                                                                                        ],
                                                                                             'line' => 23,
                                                                                             'number' => 14,
                                                                                             'patcount' => 0,
                                                                                             'strcount' => 0,
                                                                                             'uncommit' => undef
                                                                                           }, 'Parse::RecDescent::Production' )
                                                                                  ],
                                                                       'vars' => ''
                                                                     }, 'Parse::RecDescent::Rule' )
                            },
                 'startcode' => ''
               }, 'Parse::RecDescent' );
}