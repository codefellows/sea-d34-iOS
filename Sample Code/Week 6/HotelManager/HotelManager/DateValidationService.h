//
//  DateValidationService.h
//  HotelManager
//
//  Created by Bradley Johnson on 5/6/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateValidationService : NSObject

+ (BOOL)validateFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
