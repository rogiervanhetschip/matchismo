//
//  SetDeck.m
//  Matchismo
//
//  Created by Rogier van het Schip on 14/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (id) init
{
    self = [super init];
    
    if(self)
    {
        for (NSString *fill in [SetCard validFills])
        {
            for(NSString *color in [SetCard validColors])
            {
                for(int number = 0; number < [SetCard maxNumber]; number++)
                {
                    SetCard *card = [[SetCard alloc]init]; // TODO: Kleur, number en fill zetten
                    card.fill = fill;
                    card.color = color;
                    card.number = number;
                    [self addCard:card atTop:YES];
                }
            }
        }
    }
    
    return self;
}

@end
