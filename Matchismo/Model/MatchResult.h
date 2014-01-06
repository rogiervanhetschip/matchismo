//
//  MatchResult.h
//  Matchismo
//
//  Created by Rogier van het Schip on 1/6/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchResult : NSObject

// Designated initializer
- (instancetype)initWithSelectedCards:(NSArray *)selectedCards andPointsScored:(NSInteger) pointsScored;

@property (nonatomic, readonly) NSArray *selectedCards;
@property (nonatomic, readonly) NSInteger pointsScored;
@end
