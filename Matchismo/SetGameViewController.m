//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Rogier van het Schip on 17/01/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Game *)game
{
    if(!_game) _game = [[SetGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
    return _game;
}

- (Deck *) createDeck
{
    return [[SetDeck alloc]init];
}

- (UIColor *)colorAsUIColor:(NSString *) color
{
    if([[[SetCard validColors] objectAtIndex: 0] isEqualToString:color])
    {
        return [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    }
    else if([[[SetCard validColors] objectAtIndex: 1] isEqualToString:color])
    {
        return [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    }
    else
    {
        return [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    }
}

- (void)setCard:(SetCard *)card cardButton:(UIButton *)cardButton
{
    [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
}

- (NSAttributedString *) titleForCard:(SetCard *)card
{
    return card.isChosen ? [self cardContent:card] : [[NSAttributedString alloc] init];
}

- (NSAttributedString *)cardContents:(NSArray *)selectedCards
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]init];
    for(SetCard *card in selectedCards)
    {
        [result appendAttributedString:[self cardContent:card]];
    }
    return [[NSAttributedString alloc]initWithAttributedString:result];
}

- (NSAttributedString *)cardContent:(SetCard *)card
{
    // Create number of symbols
    NSMutableString *symbols = [[NSMutableString alloc]init];
    for(int i = 0; i < card.number; i++) {
        [symbols appendString:card.symbol];
    }
    
    // Create color
    // Fill as alpha on foregroundcolor
    UIColor *strokeColor = [self colorAsUIColor:card.color];
    UIColor *fillColor = [strokeColor colorWithAlphaComponent:[card fillAsFloat]];
    
    return [[NSAttributedString alloc] initWithString:symbols attributes:@{NSForegroundColorAttributeName: fillColor, NSStrokeColorAttributeName:strokeColor, NSStrokeWidthAttributeName:@-5.0}];
}

- (void) setMatchLabelText
{
    [self.matchLabel setAttributedText:[self getMatchLabelText]];
}

- (NSAttributedString *)getMatchLabelText
{
    NSAttributedString *result = [[NSAttributedString alloc] init];
    MatchResult *latestMatchResult = [self.game getLatestMatchResult];
    if(latestMatchResult.selectedCards.count <= 0)
    {
        [self.matchLabel setAttributedText:[[NSAttributedString alloc]init]];
    }
    else {
        if(latestMatchResult.pointsScored > 0)
        {
            // WHYYYYY!? Apple, why is this so convoluted?!
            NSMutableAttributedString *matchString = [[NSMutableAttributedString alloc] initWithString:@"Matched " attributes:nil];
            [matchString appendAttributedString:[self cardContents:latestMatchResult.selectedCards]];
            [matchString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points!", latestMatchResult.pointsScored]]];
        
            result = matchString;
        }
        else if(latestMatchResult.pointsScored < 0)
        {
         
             NSMutableAttributedString *matchString2 = [[NSMutableAttributedString alloc] initWithAttributedString:[self cardContents:latestMatchResult.selectedCards]];
             [matchString2 appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %d point penalty!", latestMatchResult.pointsScored]]];
                                                        
             result = matchString2;
        }
        else
        {
            result = [self cardContents:latestMatchResult.selectedCards];
        }
    }
    return result;
}

@end
