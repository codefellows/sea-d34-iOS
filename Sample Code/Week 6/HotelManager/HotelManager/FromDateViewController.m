//
//  FromDateViewController.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/5/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "FromDateViewController.h"
#import "ToDateViewController.h"

@interface FromDateViewController ()

@end

@implementation FromDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self.nextButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
  self.instructionsLabel.text = @"Select the first date";
  
  
//  self.dateFormatter = [[NSDateFormatter alloc] init];
//  //self.dateFormatter.dateStyle = NSDateFormatterShortStyle;
//  self.dateFormatter.dateFormat = @"MMMM/yyyy";
//  // Do any additional setup after loading the view.
}
-(void)nextPressed {
  
  NSDate *selectedDate = self.datePicker.date;
  
  ToDateViewController *toDateVC = [[ToDateViewController alloc] init];
  toDateVC.fromDate = selectedDate;
  [self.navigationController pushViewController:toDateVC animated:true];
  
//  NSString *dateString = [self.dateFormatter stringFromDate:selectedDate];
//  
//  NSLog(@"%@",dateString);
//  
//  NSDate *dateFromString = [self.dateFormatter dateFromString:dateString];
  
 // NSLog(@"%@",dateFromString);
//  NSDate *now = [NSDate date];
//  NSLog(@"now: %@",now);
//  NSDate *then = [NSDate date];
//  NSLog(@"then: %@",then);
//  NSCalendar *calendar = [NSCalendar currentCalendar];
//  NSTimeInterval interval = [then timeIntervalSinceDate:now];
//  
//
//  
//    NSDateComponents *nowComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:now];
//  NSLog(@"%ld",(long)nowComponents.day);
//  nowComponents.month = 6;
//  
//  NSDate *threeHoursFromNow = [calendar dateByAddingUnit:NSCalendarUnitHour value:3 toDate:now options:nil];
//  
//  NSDate *monthFromToday = [calendar dateFromComponents:nowComponents];
//  
//  NSLog(@"%@",monthFromToday);
  
  
}



@end
