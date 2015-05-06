//
//  DateValidationService.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/6/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "DateValidationService.h"

@implementation DateValidationService

+ (BOOL)validateFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
  
  NSComparisonResult comparison = [fromDate compare:toDate];
  
  if (comparison == NSOrderedAscending || comparison == NSOrderedSame) {
    return true;
  }
  
  return false;
}



@end
