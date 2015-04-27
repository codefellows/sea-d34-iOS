//
//  ViewController.h
//  ObjcDemo
//
//  Created by Bradley Johnson on 4/27/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface ViewController : UIViewController

@property (strong,nonatomic) Person *selectedPerson;
@property (strong,nonatomic) NSString *name;
//var name : String!

-(void)doSomething;

-(void)doSomethingWithString: (NSString *)string andThenChangeView: (UIView *)view;


@end

