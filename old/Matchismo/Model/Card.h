//
//  Card.h
//  Matchismo
//
//  Created by Rogier van het Schip on 6/18/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
