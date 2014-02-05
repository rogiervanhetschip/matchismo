 //
//  CardGameViewController.m
//  Matchismo
//
//  Created by Rogier van het Schip on 1/2/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic, readwrite) Game *game;
@property (strong, readwrite) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSMutableArray *historyTexts;
@end

@implementation CardGameViewController

- (Game *)game
{
    if(!_game) _game = [[Game alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (NSArray *)historyTexts
{
    if(!_historyTexts) _historyTexts = [[NSMutableArray alloc] init];
    return _historyTexts;
}

- (Deck *) createDeck
{
    return [[Deck alloc]init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self storeHistoryText];
    [self updateUI];
}

- (void)setCard:(Card *)card cardButton:(UIButton *)cardButton
{
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [self setCard:card cardButton:cardButton];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self setMatchLabelText];
}

- (NSString *)cardContents:(NSArray *)selectedCards
{
    NSString *result = [[NSString alloc]init];
    for(Card *card in selectedCards)
    {
        result = [result stringByAppendingString:card.contents];
    }
    return result;
}

- (void)setMatchLabelText
{
    self.matchLabel.text = [self getMatchLabelText];
}

- (NSString *)getMatchLabelText
{
    NSString *result = @"";
    MatchResult *latestMatchResult = [self.game getLatestMatchResult];
    if(latestMatchResult.selectedCards.count > 0)
    {
        if(latestMatchResult.pointsScored > 0)
        {
            result = [NSString stringWithFormat:@"Matched %@ for %d points!", [self cardContents:latestMatchResult.selectedCards], latestMatchResult.pointsScored];
        }
        else if(latestMatchResult.pointsScored < 0)
        {
            result = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", [self cardContents:latestMatchResult.selectedCards], latestMatchResult.pointsScored];
        }
        else
        {
            result = [self cardContents:latestMatchResult.selectedCards];
        }
    }
    return result;
}

- (void) storeHistoryText
{
    [self.historyTexts addObject:[self getMatchLabelText]];
}

- (NSString *) titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchRestartButton
{
    [self restart];
}

- (void)restart {
    self.game = nil; // Getter will do restart
    [self updateUI];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Set history"] || [segue.identifier isEqualToString:@"Matchem history"])
    {
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
        {
            HistoryViewController *histVC = (HistoryViewController *)segue.destinationViewController;
            histVC.historyTexts = [[NSArray alloc]initWithArray:self.historyTexts];
        }
    }
}

@end
