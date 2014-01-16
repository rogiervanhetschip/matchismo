//
//  Game.m
//  Matchismo
//
//  Created by Rogier van het Schip on 16/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "Game.h"

@interface Game()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) BOOL fresh;
@property (nonatomic, readwrite) NSInteger pointsScored;
@property (nonatomic, readwrite) NSMutableArray *cards; // of Card
@property (nonatomic, strong) MatchResult *matchResult;
@end

@implementation Game

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(id)deck
{
    self = [super init];
    
    if(self)
    {
        self = [super init];
        
        if(self)
        {
            for (int i = 0; i < count; i++)
            {
                Card *card = [deck drawRandomCard];
                if(card)
                {
                    [self.cards addObject:card];
                } else {
                    self = nil;
                    break;
                }
            }
            self.fresh = YES; // Vraag: Is dit de beste plek voor deze init?
        }
        
        return self;
    }
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    // Empty
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return [self.cards objectAtIndex:index];
}

- (instancetype) init
{
    return nil;
}

- (MatchResult *)getLatestMatchResult
{
    return self.matchResult;
}

@end
