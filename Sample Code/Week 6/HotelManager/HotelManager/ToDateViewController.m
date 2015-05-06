//
//  ToDateViewController.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/5/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "ToDateViewController.h"
#import "AvailabilityTableViewController.h"

@interface ToDateViewController ()

@end

@implementation ToDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.instructionsLabel.text = @"Select end date";
  [self.nextButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)nextPressed {
  
  NSDate *selectedDate = self.datePicker.date;
  
  AvailabilityTableViewController *availabilityTableVC = [[AvailabilityTableViewController alloc] init];
  availabilityTableVC.fromDate = self.fromDate;
  availabilityTableVC.toDate = selectedDate;
  [self.navigationController pushViewController:availabilityTableVC animated:true];
  
 }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
