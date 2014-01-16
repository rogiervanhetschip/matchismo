//
//  SetGame.m
//  Matchismo
//
//  Created by Rogier van het Schip on 14/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "SetGame.h"

@implementation SetGame

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(id)deck
{
    self = [super init];
    
    if(self)
    {
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 1;
static const int MATCH_BONUS = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    
}


@end
