//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Rogier van het Schip on 6/19/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "CardMatchingGame.h"

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (FlipResult *)flipCardAtIndex:(NSUInteger)index
{
    FlipResult *result = [[FlipResult alloc]init];
    return result;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (int)getScore
{
    return self.score;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self)
    {
        for(int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
            self.cards[i] = card;
            }
            else
            {
                self = nil;
                break;
            }
        }
        self.fresh = YES;
    }
    return self;
}

@end
