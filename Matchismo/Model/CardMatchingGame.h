//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Rogier van het Schip on 1/3/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "MatchResult.h"

@interface CardMatchingGame : NSObject

// Designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(id)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (MatchResult *)getLatestMatchResult;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly, getter=isFresh) BOOL fresh;
@property (nonatomic) NSInteger cardsToMatch;

@end
