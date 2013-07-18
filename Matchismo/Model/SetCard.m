//
//  SetCard.m
//  Matchismo
//
//  Created by Rogier van het Schip on 7/4/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count]!=2) {
        SetCard *otherCard1 = otherCards[0];
        SetCard *otherCard2 = [otherCards lastObject];
        if([self colorsMatchOrDiffer:otherCard1 and: otherCard2] && [self fillsMatchOrDiffer:otherCard1 and: otherCard2] && [self shapesMatchOrDiffer:otherCard1 and: otherCard2]) {
            score = 10;
        }
    }
    return score;
}

- (BOOL)colorsMatchOrDiffer:(SetCard *)otherCard1 and:(SetCard *)otherCard2
{
    return ([otherCard1.color isEqual:self.color] && [otherCard2.color isEqual:self.color]) ||
    (![otherCard1.color isEqual:self.color] && ![otherCard1.color isEqual:otherCard2.color] && ![otherCard2.color isEqual:self.color]);
}

- (BOOL)shapesMatchOrDiffer:(SetCard *)otherCard1 and:(SetCard *)otherCard2
{
    return ([otherCard1.shape isEqual:self.shape] && [otherCard2.shape isEqual:self.shape]) ||
    (![otherCard1.shape isEqual:self.shape] && ![otherCard1.shape isEqual:otherCard2.shape] && ![otherCard2.shape isEqual:self.shape]);
}

- (BOOL)fillsMatchOrDiffer:(SetCard *)otherCard1 and:(SetCard *)otherCard2
{
    return ([otherCard1.alpha isEqual:self.alpha] && [otherCard2.alpha isEqual:self.alpha]) ||
    (![otherCard1.alpha isEqual:self.alpha] && ![otherCard1.alpha isEqual:otherCard2.alpha] && ![otherCard2.alpha isEqual:self.alpha]);
}

- (NSString *)contents
{
    UIColor *strokeColor = self.color;
    UIColor *fillColor = [strokeColor colorWithAlphaComponent:[self.alpha floatValue]];
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]initWithString:self.shape attributes:@{NSForegroundColorAttributeName:fillColor, NSStrokeWidthAttributeName:@-5, NSStrokeColorAttributeName:strokeColor}];
    return [result string];
}

+ (NSArray *)validShapes
{
    return @[@"▲",@"●",@"■"];
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape])
    {
        _shape = shape;
    }
}

+ (NSArray *)validColors
{
    return @[[UIColor redColor],[UIColor greenColor],[UIColor redColor]];
}

- (void)setColor:(UIColor *)color
{
    if ([[SetCard validColors] containsObject:color])
    {
        _color = color;
    }
}

+ (NSArray *)validAlphas
{
    return @[@1,@0.5,@0];
}

- (void)setFill:(NSNumber *)alpha
{
    if ([[SetCard validAlphas] containsObject:alpha])
    {
        _alpha = alpha;
    }
}

@end
