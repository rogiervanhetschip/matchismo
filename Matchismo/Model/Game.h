//
//  Game.h
//  Matchismo
//
//  Created by Rogier van het Schip on 16/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchResult.h"
#import "Card.h"

@interface Game : NSObject

// Designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(id)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (MatchResult *)getLatestMatchResult;

@property (nonatomic) NSInteger score; // protected
@property (nonatomic, getter=isFresh) BOOL fresh; // protected
@property (nonatomic, strong) MatchResult *matchResult; // protected
@property (nonatomic, readonly) NSMutableArray *cards; // of Card

@end
