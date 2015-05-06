//
//  DateValidationServiceTests.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/6/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DateValidationService.h"

@interface DateValidationServiceTests : XCTestCase
@property (strong,nonatomic) NSDate *today;
@property (strong,nonatomic) NSDate *tomorrow;
@property (strong,nonatomic) NSCalendar *calendar;


@end

@implementation DateValidationServiceTests

- (void)setUp {
    [super setUp];
  
  self.today = [NSDate date];
 self.calendar = [NSCalendar currentCalendar];
  self.tomorrow = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:self.today options:0];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDateValidationForValidDates {

  BOOL isValid = [DateValidationService validateFromDate:self.today toDate: self.tomorrow];
  
  XCTAssertTrue(isValid,@"Valid dates returned false validation");
}

-(void)testDateValidationForInvalidDates {
  
  BOOL isValid = [DateValidationService validateFromDate:self.tomorrow toDate:self.today];
  
  XCTAssertFalse(isValid,@"Invalid dates returned a true validation");
}

-(void)testDateValidationForSameDates {
  BOOL isValid = [DateValidationService validateFromDate:self.today toDate:self.today];
  
  XCTAssertTrue(isValid,@"Same dates returned a false validation");
  
}

@end
