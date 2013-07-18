//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Rogier van het Schip on 6/19/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#import "FlipResult.h"

@interface CardMatchingGame : NSObject

// Designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

@property (strong, nonatomic) NSMutableArray *cards; // of Card

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (FlipResult *)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) int score;
@property (nonatomic, getter=isFresh) BOOL fresh;

@end
