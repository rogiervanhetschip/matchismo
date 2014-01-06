//
//  MatchResult.m
//  Matchismo
//
//  Created by Rogier van het Schip on 1/6/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "MatchResult.h"

@interface MatchResult()
@property (nonatomic, readwrite) NSArray *selectedCards;
@property (nonatomic, readwrite) NSInteger pointsScored;
@end

@implementation MatchResult

- (instancetype)initWithSelectedCards:(NSArray *)selectedCards andPointsScored:(NSInteger) pointsScored
{
    self = [super init];
    
    if(self)
    {
        self.selectedCards = selectedCards;
        self.pointsScored = pointsScored;
    }
    
    return self;
}
@end


