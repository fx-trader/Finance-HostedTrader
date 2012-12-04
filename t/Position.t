#!/usr/bin/perl

use strict;
use warnings;
use Test::More tests => 21;
use Test::Exception;
use Data::Dumper;

BEGIN {
use_ok ('Finance::HostedTrader::Position');
}
use Finance::HostedTrader::Trade;


    my $trade_EURUSD = Finance::HostedTrader::Trade->new( size => 1000,
                                                direction => 'long',
                                                openPrice => 1.1,
                                                id => 1.1,
                                                symbol => 'EURUSD',
                                                openDate => '2010-01-01 00:00:00',
                                              );

    my $trade_USDJPY = Finance::HostedTrader::Trade->new( size => 1000,
                                                direction => 'long',
                                                openPrice => 1.1,
                                                id => 1.1,
                                                symbol => 'USDJPY',
                                                openDate => '2010-01-01 00:00:00',
                                              );

    my $trade_USDJPY2 = Finance::HostedTrader::Trade->new( size => -2000,
                                                direction => 'short',
                                                openPrice => 1.1,
                                                id => -1.1,
                                                symbol => 'USDJPY',
                                                openDate => '2010-02-01 00:00:00',
                                              );

    my $trade_USDJPY3 = Finance::HostedTrader::Trade->new( size => 2000,
                                                direction => 'long',
                                                openPrice => 1.25,
                                                id => 1.2,
                                                symbol => 'USDJPY',
                                                openDate => '2010-02-01 00:00:00',
                                              );


    {
    diag("General test, check invalid conditions throw exceptions, check add/delete trades works");
    my $position;
    throws_ok { 
        $position = Finance::HostedTrader::Position->new()
    } qr/Attribute \(symbol\) is required/, 'Dies without size attribute';

    $position = Finance::HostedTrader::Position->new( symbol => 'USDJPY' );
    throws_ok { $position->addTrade($trade_EURUSD) } qr/Trade has symbol EURUSD but position has symbol USDJPY/, 'Cannot add trades with different symbols';
    lives_ok { $position->addTrade($trade_USDJPY)} 'Can add trades with same symbol';
    throws_ok { $position->addTrade($trade_USDJPY)} qr/Trade already exists in position/, 'Duplicate trade';

    is_deeply($position->getTrade('1.1'), $trade_USDJPY, 'getTrade');
    is_deeply($position->getOpenTradeList(), [ $trade_USDJPY ], 'getOpenTradeList');
    ok($position->size() == 1000, 'size');
    ok($position->averagePrice() == 1.1, 'averagePrice');

    $position->addTrade($trade_USDJPY2);
    is_deeply($position->getTrade('-1.1'), $trade_USDJPY2, 'getTrade');
    is_deeply($position->getOpenTradeList(), [ $trade_USDJPY, $trade_USDJPY2 ], 'getOpenTradeList');
    ok($position->size() == -1000, 'size');
    ok($position->averagePrice() == 1.1, 'averagePrice');

    $position->deleteTrade('1.1');
    is_deeply($position->getOpenTradeList(), [ $trade_USDJPY2 ], 'getOpenTradeList');
    ok($position->size() == -2000, 'size');
    ok($position->averagePrice() == 1.1, 'averagePrice');

    $position->deleteTrade('-1.1');
    is_deeply($position->getOpenTradeList(), [ ], 'getOpenTradeList');
    ok($position->size() == 0, 'size');
    ok(!defined($position->averagePrice()), 'averagePrice');
    }

    {
        diag("Add two trades with different quantities and price. check position size and average price");
        my $position = Finance::HostedTrader::Position->new( symbol => 'USDJPY' );
        $position->addTrade($trade_USDJPY);
        $position->addTrade($trade_USDJPY3);
        is($position->size(), 3000, "Position size");
        is($position->averagePrice(), 1.2, "Average Price");
    }
