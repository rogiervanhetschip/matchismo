//
//  SetCard.m
//  Matchismo
//
//  Created by Rogier van het Schip on 14/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSAttributedString *)contents
{
    // Create number of symbols
    NSMutableString *symbols = nil;
    while (symbols.length < self.number) {
        [symbols appendString:self.symbol];
    }
    
    // Create color
    // Fill as alpha
    UIColor *color = [[self colorAsUIColor] colorWithAlphaComponent: [self fillAsFloat]];
    
    return [[NSAttributedString alloc] initWithString:symbols attributes:@{NSForegroundColorAttributeName: color}];
}

- (int)match:(NSArray *)otherCards
{
    int result = 0;
    if (otherCards.count == 2)
    {
        if([self fillIsEqualOrDifferentFromCards:otherCards] &&
           [self numberIsEqualOrDifferentFromCards:otherCards] &&
           [self colorIsEqualOrDifferentFromCards:otherCards])
        {
            result = 1;
        }
    }
    return result;
}

- (BOOL)fillIsEqualOrDifferentFromCards:(NSArray *)otherCards
{
    SetCard *otherCard0 = (SetCard *)otherCards[0];
    SetCard *otherCard1 = (SetCard *)otherCards[1];
    // Fills are all different, or all equal
    return (self.fill != otherCard0.fill && self.fill != otherCard1.fill && otherCard0.fill != otherCard1.fill) || (self.fill == otherCard0.fill && self.fill == otherCard1.fill);
}

- (BOOL)numberIsEqualOrDifferentFromCards:(NSArray *)otherCards
{
    SetCard *otherCard0 = (SetCard *)otherCards[0];
    SetCard *otherCard1 = (SetCard *)otherCards[1];
    // Numbers are all different, or all equal
    return (self.number != otherCard0.number && self.number != otherCard1.number && otherCard0.number != otherCard1.number) || (self.number == otherCard0.number && self.number == otherCard1.number);
}

- (BOOL)colorIsEqualOrDifferentFromCards:(NSArray *)otherCards
{
    SetCard *otherCard0 = (SetCard *)otherCards[0];
    SetCard *otherCard1 = (SetCard *)otherCards[1];
    // Colors are all different, or all equal
    return (self.color != otherCard0.color && self.color != otherCard1.color && otherCard0.color != otherCard1.color) || (self.color == otherCard0.color && self.color == otherCard1.color);
}

- (void)setColor:(NSString *)color
{
    if([[SetCard validColors] containsObject:color])
    {
        _color = color;
    }
}

// Vraag: Hoort dit in model of viewcontroller? Dat we UIColor gebruiken, is een UI keuze, dus viewcontroller, zou je zeggen.
- (UIColor *)colorAsUIColor
{
    if([[[SetCard validColors] objectAtIndex: 0] isEqualToString:[self color]])
    {
        return [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    }
    else if([[[SetCard validColors] objectAtIndex: 1] isEqualToString:[self color]])
    {
        return [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    }
    else
    {
        return [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    }
}

- (void)setFill:(NSString *)fill
{
    if([[SetCard validFills] containsObject:fill])
    {
        _fill = fill;
    }
}

- (CGFloat)fillAsFloat
{
    if([[[SetCard validFills] objectAtIndex:0] isEqualToString:self.fill])
        {
            return (CGFloat)0.0;
        }
        else if([[[SetCard validFills] objectAtIndex:1] isEqualToString:self.fill])
        {
            return (CGFloat)0.5;
        }
        else
        {
            return (CGFloat)1.0;
        }
}

- (void)setNumber:(NSInteger)number
{
    if([SetCard maxNumber] >= number)
    {
        _number = number;
    }
}

- (void)setSymbol:(NSString *)symbol
{
    if([[SetCard validSymbols] containsObject:symbol])
    {
        _symbol = symbol;
    }
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *)validFills
{
    return @[@"empty", @"half", @"full"];
}

+ (NSInteger)maxNumber
{
    return 3;
}

+ (NSArray *)validSymbols
{
    return @[@"▲", @"◼︎", @"●"];
}

@end
