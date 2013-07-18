//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Rogier van het Schip on 6/18/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "TwoCardMatchingGame.h"
#import "ThreeCardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) UIImage *cardBack;
@property (strong, nonatomic) NSString *matchResult;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if(!_game)
    {
        Deck *deck = [[PlayingCardDeck alloc] init];
        if([self.gameModeControl selectedSegmentIndex] == 1)
        {
            _game = [[ThreeCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:deck];
        } else {
            _game = [[TwoCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:deck];
        }
    }
    return _game;
}

- (UIImage *)cardBack
{
    if(!_cardBack)
    {
        _cardBack = [UIImage imageNamed:@"13791242-playing-card-back-side.jpg"];
    }
    return _cardBack;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        [cardButton setImage:[self cardBack] forState: UIControlStateNormal];
        [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected];
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.matchLabel.text = self.matchResult;
    self.gameModeControl.enabled = self.game.isFresh;
}

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    // Flip card
    FlipResult *result = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    if(result.result == -1)
    {
        // Mismatch
        // TODO: Violation of open-closed principle!
        if([self.game isKindOfClass:[TwoCardMatchingGame class]])
        {
            self.matchResult = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", result.comparedCards[0], result.comparedCards[1], MISMATCH_PENALTY];
        }
        else if ([self.game isKindOfClass:[ThreeCardMatchingGame class]])
        {
            self.matchResult = [NSString stringWithFormat:@"%@, %@ and %@ don't match! %d point penalty!", result.comparedCards[0], result.comparedCards[1], result.comparedCards[2], MISMATCH_PENALTY];
        }
    } else if (result.result == 1)
    {
        // Match
        if([self.game isKindOfClass:[TwoCardMatchingGame class]])
        {
            self.matchResult = [NSString stringWithFormat:@"Matched %@ and %@ for %d points!", result.comparedCards[0], result.comparedCards[1], MATCH_BONUS];
        } else if ([self.game isKindOfClass:[ThreeCardMatchingGame class]])
        {
            self.matchResult = [NSString stringWithFormat:@"Matched %@, %@ and %@ for %d points!", result.comparedCards[0], result.comparedCards[1], result.comparedCards[2], MATCH_BONUS];
        }
    } else if(result.result == 2){
        self.matchResult = [NSString stringWithFormat:@"Flipped up %@", result.comparedCards[0]];
    } else {
        self.matchResult = nil;
    }
    self.flipCount++;
    [self updateUI];
}

- (IBAction)switchGameMode:(UISegmentedControl *)sender {
    if(self.game.fresh)
    {
        [self reset];
    } else {
        // throw exception, as UI and game are out of sync
    }
}

- (IBAction)deal:(id)sender {
    [self reset];
}

- (void)reset
{
    self.game = nil; // Setter will do init
    self.flipCount = 0;
    self.matchResult = nil;
    [self updateUI];
}

@end
