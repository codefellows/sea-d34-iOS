//
//  MainMenuTableViewController.h
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/11/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuSelectionDelegate.h"

@interface MainMenuTableViewController : UITableViewController

@property (weak,nonatomic) id<MenuSelectionDelegate> delegate;

@end
