//
//  SetDeck.m
//  Matchismo
//
//  Created by Rogier van het Schip on 7/4/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (id)init
{
    self = [super init];
    
    if(self) {
        for (UIColor *color in [SetCard validColors]) {
            for (NSNumber *alpha in [SetCard validAlphas]) {
                for(NSString *shape in [SetCard validShapes]) {
                    SetCard *card = [[SetCard alloc] init];
                    card.shape = shape;
                    card.color = color;
                    card.alpha = alpha;
                    [self addCard:card atTop:YES];
                }
            }
        }
    }
    
    return self;
}

@end
