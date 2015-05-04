//
//  ViewController.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/4/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 50, 50)];
  blueView.backgroundColor = [UIColor blueColor];
  [rootView addSubview:blueView];
  [blueView setTranslatesAutoresizingMaskIntoConstraints:false];
  
  UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
  greenView.backgroundColor = [UIColor greenColor];
  [rootView addSubview:greenView];
  [greenView setTranslatesAutoresizingMaskIntoConstraints:false];
  
  UIButton *doneButton = [[UIButton alloc] init];
  [doneButton setTitle:@"Done" forState:UIControlStateNormal];
  [doneButton setBackgroundColor:[UIColor yellowColor]];
  [rootView addSubview:doneButton];
  [doneButton setTranslatesAutoresizingMaskIntoConstraints:false];
  
  
  NSDictionary *views = @{@"blueView" : blueView, @"greenView" : greenView, @"doneButton" : doneButton};
  
  [self addConstraintsToRootView:rootView withViews:views];
  
  
  self.view = rootView;
}
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

-(void)addConstraintsToRootView:(UIView *)rootView withViews:(NSDictionary *)views {
  
  NSArray *blueViewHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[blueView(40)]" options:0 metrics:nil views:views];
  
  UIView *blueView = views[@"blueView"];
  [blueView addConstraints:blueViewHeight];
  
  NSArray *greenViewHeight = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[greenView(40)]" options:0 metrics:nil views:views];
  UIView *greenView = views[@"greenView"];
  [greenView addConstraints:greenViewHeight];
  
  NSArray *blueViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[blueView]-[greenView(40)]-|" options:0 metrics:nil views:views];
  [rootView addConstraints:blueViewHorizontal];
  
  NSArray *blueViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[blueView]" options:0 metrics:nil views:views];
  [rootView addConstraints:blueViewVertical];
  
  NSArray *greenViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[greenView]" options:0 metrics:nil views:views];
  [rootView addConstraints:greenViewVertical];
  
  UIButton *doneButton = views[@"doneButton"];
  
  NSLayoutConstraint *doneButtonCenterX = [NSLayoutConstraint constraintWithItem:doneButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
  
  NSLayoutConstraint *doneButtonCenterY = [NSLayoutConstraint constraintWithItem:doneButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
  
  [rootView addConstraints:@[doneButtonCenterX,doneButtonCenterY]];
  

  
}

@end
