//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Rogier van het Schip on 17/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Game *)game
{
    if(!_game) _game = [[SetGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
    return _game;
}

- (Deck *) createDeck
{
    return [[SetDeck alloc]init];
}

@end
