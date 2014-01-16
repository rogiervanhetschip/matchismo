//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Rogier van het Schip on 1/3/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) BOOL fresh;
@property (nonatomic, readwrite) NSInteger pointsScored;
@property (nonatomic, strong) MatchResult *matchResult;
@end

@implementation CardMatchingGame

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(id)deck
{
    self = [super init];
    
    if(self)
    {
        self.cardsToMatch = 2;
    }
    
    return self;
}

static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSInteger pointsScored = 0;
    
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
        } else {
            // Match against other cards
            // TODO: We can currently only match the otherCards against
            // card, not otherCards amongst themselves
            NSMutableArray  *chosenCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    [chosenCards addObject:otherCard];
                }
            }
            NSMutableArray *allChosenCards = [[NSMutableArray alloc]initWithArray:chosenCards];
            [allChosenCards addObject:card];
            
            if(allChosenCards.count >= self.cardsToMatch)
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
            self.score -= COST_TO_CHOOSE;
            self.matchResult = [[MatchResult alloc] initWithSelectedCards:allChosenCards andPointsScored:pointsScored];
        }
    }
    
    if(self.isFresh)
    {
        self.fresh = NO;
    }
}

@end
