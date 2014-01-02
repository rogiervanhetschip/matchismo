//
//  SetMatchingGame.m
//  Matchismo
//
//  Created by Rogier van het Schip on 7/4/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "SetMatchingGame.h"

@implementation SetMatchingGame

- (FlipResult *)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    FlipResult * result = [[FlipResult alloc]init];
    
    if(card && !card.isUnplayable) {
        if(!card.isFaceUp) {
            result.comparedCards = @[card.contents];
            result.result = 2;
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    result.comparedCards = @[card.contents, otherCard.contents];
                    for (Card *thirdCard in self.cards) {
                        if(thirdCard.isFaceUp && !thirdCard.isUnplayable && otherCard != thirdCard) {
                            result.comparedCards = @[card.contents, otherCard.contents, thirdCard.contents];
                            int matchScore = [card match:@[otherCard, thirdCard]];
                            if(matchScore)
                            {
                                card.unplayable = YES;
                                otherCard.unplayable = YES;
                                thirdCard.unplayable = YES;
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
                    // Set has no flip cost
                }
                card.faceUp = !card.isFaceUp;
            }
        }
    }
    return result;
}

@end
