//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Rogier van het Schip on 05/02/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *historyText;
@end

@implementation HistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.slider.minimumValue = 0.0f;
    self.slider.value = 0.0f;
    self.slider.maximumValue = self.historyTexts.count - 1;
}

- (IBAction)moveSlider {
    id text = [self.historyTexts objectAtIndex:round(self.slider.value)];
    if ([text isKindOfClass:[NSString class]])
    {
        self.historyText.text = text;
    }
    else if([text isKindOfClass:[NSAttributedString class]])
    {
        [self.historyText setAttributedText:text];
    }
}

@end
