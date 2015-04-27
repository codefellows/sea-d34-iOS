//
//  ViewController.m
//  ObjcDemo
//
//  Created by Bradley Johnson on 4/27/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong,nonatomic) UIView *specialView;
@property (strong,nonatomic) NSString *myName;
@property (nonatomic) CGRect myFrame;

@property (strong,nonatomic) NSString *myTeam;



@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
//  [self setMyName:@"Brad"];
//  self.myName = @"Brad";
//  
//  
//  NSString *name = [self myName];
//  NSString *anotherName = self.myName;
//  
  //Person *myPerson = [[Person alloc] initWithName:@"Brad"];
  
  NSString *name = @"brad";
  NSArray *stuff = @[@"Hi",@"Hello",@(14)];
  NSDictionary *info = @{@"Brad" : @"Johnson"};
  NSNumber *myNumber = @(31);
  
  CGRect newFrame = CGRectMake(0, 0, 200, 200);
  
  
  name = @"hello";
  
  int number = 31;
  NSString *anotherName = name;

  NSLog(@"%p, %p", &name, anotherName);
  
  //[self doSomethingWithString:@"Brad" andThenChangeView:self.view];
  
  // Do any additional setup after loading the view, typically from a nib.
}

-(void)doSomething {
  
}

-(void)doSomethingWithString:(NSString *)string andThenChangeView:(UIView *)view {
  
}

@end
