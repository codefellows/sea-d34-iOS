//
//  HotelServiceTests.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/6/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CoreDataStack.h"
#import "HotelService.h"
#import "Hotel.h"
#import "Room.h"


@interface HotelServiceTests : XCTestCase
@property (strong,nonatomic) CoreDataStack *coreDataStack;
@property (strong,nonatomic) HotelService *hotelService;


@end

@implementation HotelServiceTests

- (void)setUp {
    [super setUp];
  
  self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  self.hotelService = [[HotelService alloc] initWithCoreDataStack:self.coreDataStack];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  self.coreDataStack = nil;
  self.hotelService = nil;
    [super tearDown];
}

-(void)testFetchAvailableRoomsWithNoReservations {
  Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  hotel.name = @"Hotel";
  hotel.location = @"Location";
  Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  room.number = @1;
  room.rate = [[NSDecimalNumber alloc] initWithDouble:1.0];
  room.rating = @1;
  room.beds = @1;
  room.hotel = hotel;
  
  NSDate *today = [NSDate date];
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDate *tomorrow = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:today options:0];
  
  
  NSArray *availableRooms = [self.hotelService fetchAvailableRoomsForFromDate:today toDate:tomorrow];
  
  XCTAssert(availableRooms.count == 1, @"Fetch for available rooms returned non one number for one room and zero reservations"); 
}

- (void)testFetchAllHotelsForZeroHotels {
  
  NSArray *results = [self.hotelService fetchAllHotels];
  
  XCTAssert(results.count == 0,@"Fetch for zero hotels returned non zero result");
}

-(void)testFetchAllHotelsForMultipleHotels {
  
  Hotel *hotel1 = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  hotel1.name = @"Hotel1";
  hotel1.location = @"Location1";
  
  Hotel *hotel2 = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  hotel2.name = @"Hotel2";
  hotel2.location = @"Location2";
  
  NSArray *results = [self.hotelService fetchAllHotels];
  
  XCTAssert(results.count == 2, @"Fetch for two hotels did not return two");
}



@end
