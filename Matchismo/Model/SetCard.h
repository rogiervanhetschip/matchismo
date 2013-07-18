//
//  SetCard.h
//  Matchismo
//
//  Created by Rogier van het Schip on 7/4/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSNumber *alpha;
@property (strong, nonatomic) NSString *shape;

+ (NSArray *) validShapes;
+ (NSArray *) validAlphas;
+ (NSArray *) validColors;

@end
