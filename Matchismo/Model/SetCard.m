//
//  SetCard.m
//  Matchismo
//
//  Created by Rogier van het Schip on 14/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    // TODO
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *)validFills
{
    return @[@"empty", @"half", @"full"];
}

+ (NSUInteger *)maxNumber
{
    return @3;
}

@end
