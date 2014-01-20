 //
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Rogier van het Schip on 17/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Game *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
    return _game;
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc]init];
}

@end
