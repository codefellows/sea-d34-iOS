//
//  HotelService.h
//  HotelManager
//
//  Created by Bradley Johnson on 5/6/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoreDataStack;
@class NSFetchedResultsController;
@class Reservation;
@class Room;
@interface HotelService : NSObject

-(instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack;

-(NSArray *)fetchAllHotels;

-(NSArray *)fetchAvailableRoomsForFromDate:(NSDate*)fromDate toDate:(NSDate *)toDate;

-(NSFetchedResultsController *)produceFetchedResultsControllerForAllReservations;

-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@property (strong,nonatomic) CoreDataStack *coreDataStack;

@end
