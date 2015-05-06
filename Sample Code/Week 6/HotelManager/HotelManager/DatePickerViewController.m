//
//  DatePickerViewController.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/5/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

-(void)loadView {
  
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor whiteColor];
  
  self.datePicker = [[UIDatePicker alloc] init];
  self.datePicker.datePickerMode = UIDatePickerModeDate;
  [rootView addSubview:self.datePicker];
  [self.datePicker setTranslatesAutoresizingMaskIntoConstraints:false];
  
  self.instructionsLabel = [[UILabel alloc] init];
  //instructionsLabel.text = @"Select the start date";
  [self.instructionsLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.instructionsLabel];
  
  self.nextButton = [[UIButton alloc] init];
  [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
  [self.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [self.nextButton setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.nextButton];
  
  NSDictionary *views = @{@"datePicker" : self.datePicker, @"instructionsLabel" : self.instructionsLabel, @"nextButton" : self.nextButton};
  
  [self addConstraintsToRootView:rootView forViews:views];
  
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addConstraintsToRootView:(UIView *)rootView forViews:(NSDictionary *)views {
  
  NSLayoutConstraint *datePickerCenterX = [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  
  NSLayoutConstraint *datePickerCenterY = [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
  
  [rootView addConstraints:@[datePickerCenterX, datePickerCenterY]];
  
  UILabel  *instructionsLabel = views[@"instructionsLabel"];
  
  NSLayoutConstraint *labelCenterX = [NSLayoutConstraint constraintWithItem:instructionsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [rootView addConstraint:labelCenterX];
  
  NSArray *labelYConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[instructionsLabel]-[datePicker]" options:0 metrics:nil views:views];
  [rootView addConstraints:labelYConstraints];
  
  NSLayoutConstraint *buttonCenterX = [NSLayoutConstraint constraintWithItem:self.nextButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
  [rootView addConstraint:buttonCenterX];
  
  NSArray *buttonYConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[datePicker]-20-[nextButton]" options:0 metrics:nil views:views];
  [rootView addConstraints:buttonYConstraints];
  
}

@end
