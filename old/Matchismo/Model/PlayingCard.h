//
//  PlayingCard.h
//  Matchismo
//
//  Created by Rogier van het Schip on 6/18/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
