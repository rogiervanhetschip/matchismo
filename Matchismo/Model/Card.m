//
//  Card.m
//  Matchismo
//
//  Created by Rogier van het Schip on 6/18/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
