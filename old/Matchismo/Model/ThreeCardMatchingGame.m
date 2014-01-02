//
//  ThreeCardMatchingGame.m
//  Matchismo
//
//  Created by Rogier van het Schip on 6/20/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@implementation ThreeCardMatchingGame

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
                    for (Card *thirdCard in self.cards) {
                        if(thirdCard.isFaceUp && !thirdCard.isUnplayable && otherCard != thirdCard) {
                            result.comparedCards = @[card.contents, otherCard.contents, thirdCard.contents];
                            int matchScore = [card match:@[otherCard]];
                            int matchScore2 = [card match:@[thirdCard]];
                            if(matchScore && matchScore2) // TODO: This only matches if card 1 matches 2 and 3, not if 2 matches 3
                            {
                                card.unplayable = YES;
                                otherCard.unplayable = YES;
                                thirdCard.unplayable = YES;
                                self.score += matchScore * matchScore2 * MATCH_BONUS;
                                result.result = 1;
                            }
                            else
                            {
                                thirdCard.faceUp = NO;
                                otherCard.faceUp = NO;
                                self.score -= MISMATCH_PENALTY;
                                result.result = -1;
                            }
                            break;
                        }
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
    return result;
}

@end
