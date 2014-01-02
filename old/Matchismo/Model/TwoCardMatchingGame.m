//
//  TwoCardMatchingGame.m
//  Matchismo
//
//  Created by Rogier van het Schip on 6/20/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "TwoCardMatchingGame.h"

@implementation TwoCardMatchingGame

- (FlipResult *)flipCardAtIndex:(NSUInteger)index
{
    self.fresh = false; // TODO: Code duplication
    Card *card = [self cardAtIndex:index];
    FlipResult * result = [[FlipResult alloc]init];
    
    if(card && !card.isUnplayable) {
        if(!card.isFaceUp) {
            result.comparedCards = @[card.contents];
            result.result = 2;
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    result.comparedCards = @[card.contents, otherCard.contents];
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore)
                    {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        result.result = 1;
                    }
                    else
                    {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        result.result = -1;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
    return result;
}

@end
