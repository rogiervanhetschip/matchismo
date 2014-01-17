//
//  SetCard.h
//  Matchismo
//
//  Created by Rogier van het Schip on 14/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *fill;
@property (nonatomic) NSInteger number;

+ (NSArray *)validFills;
+ (NSArray *)validColors;
+ (NSInteger) maxNumber;

@end
