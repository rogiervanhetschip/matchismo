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
    self = [super initWithCardCount:count usingDeck:deck];
    
    if(self)
    {
        // No additional init required
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 1;
static const int MATCH_BONUS = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSInteger pointsScored = 0;
    
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
        } else {
            // Match against other cards
            NSMutableArray  *chosenCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    [chosenCards addObject:otherCard];
                }
            }
            NSMutableArray *allChosenCards = [[NSMutableArray alloc]initWithArray:chosenCards];
            [allChosenCards addObject:card];
            
            if(allChosenCards.count >= 3)
            {
                int matchScore = [card match:chosenCards];
                if(matchScore) {
                    pointsScored = matchScore * MATCH_BONUS;
                    self.score += pointsScored;
                    card.matched = YES;
                    for(Card *otherCard in chosenCards)
                    {
                        otherCard.matched = YES;
                    }
                } else {
                    self.score -= MISMATCH_PENALTY;
                    pointsScored = -MISMATCH_PENALTY;
                    for(Card *otherCard in chosenCards)
                    {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            card.chosen = YES;
            self.matchResult = [[MatchResult alloc] initWithSelectedCards:allChosenCards andPointsScored:pointsScored];
        }
    }
    
    if(self.isFresh)
    {
        self.fresh = NO;
    }

}


@end
