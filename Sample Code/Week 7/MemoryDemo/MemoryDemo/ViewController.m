//
//  ViewController.m
//  MemoryDemo
//
//  Created by Bradley Johnson on 5/13/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (retain,nonatomic) NSString *myTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *myName = [[NSString alloc] initWithString:@"Brad"];
  
  
  // Do any additional setup after loading the view, typically from a nib.
  //
//  NSLog(@"%@",myName);
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
  [storyboard retain];
  UIViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
  
  [self presentViewController:loginVC animated:true completion:nil];
  [storyboard release];
  
}

-(void)setMyTitle:(NSString *)myTitle {
  [myTitle retain];
  [_myTitle release];
  
  _myTitle = myTitle;
}

-(NSString *)myName {
    NSString *myName = [[NSString alloc] initWithString:@"Brad"];
  [myName autorelease];
  
  return myName;
}


-(void)dealloc {
  [_myTitle release];
  //[myName release];
}

@end
