//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Rogier van het Schip on 7/4/13.
//  Copyright (c) 2013 Rogier van het Schip. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetMatchingGame.h"
#import "SetDeck.h"

@interface SetGameViewController ()

@property (strong, nonatomic) SetMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) NSString *matchResult;

@end

@implementation SetGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateNormal];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    FlipResult *result = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    if(result.result == 1) // Match
    {
        self.matchResult = [NSString stringWithFormat:@"Matched %@, %@ and %@ for %d points!", result.comparedCards[0], result.comparedCards[1], result.comparedCards[2], MATCH_BONUS];
    }
    else if (result.result == -1) // No match
    {
        self.matchResult = [NSString stringWithFormat:@"%@, %@ and %@ don't match! %d point penalty!", result.comparedCards[0], result.comparedCards[1], result.comparedCards[2], MISMATCH_PENALTY];
    }
    self.flipCount++;
    [self updateUI];
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

- (SetMatchingGame *)game
{
    if(!_game)
    {
        Deck *deck = [[SetDeck alloc]init];
        _game = [[SetMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:deck];
    }
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
