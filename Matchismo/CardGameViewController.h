//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Rogier van het Schip on 1/2/14.
//  Copyright (c) 2014 Rogier van het Schip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface CardGameViewController : UIViewController {
    @protected
    Game *_game;
}

@property (strong, readonly) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic, readonly) Game *game; // Protected

@end
