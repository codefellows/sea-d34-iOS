//
//  HotelService.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/6/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "HotelService.h"
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"

@interface HotelService ()
@property (strong,nonatomic) CoreDataStack *coreDataStack;
@end

@implementation HotelService

-(instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack {
  self = [super init];
  if (self) {
    self.coreDataStack = coreDataStack;
  }
  return self;
}

-(NSArray *)fetchAllHotels {
  
  NSFetchRequest *hotelFetch = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:hotelFetch error:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
    return nil;
  }
  return results;
}

-(NSArray *)fetchAvailableRoomsForFromDate:(NSDate*)fromDate toDate:(NSDate *)toDate {
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@",toDate,fromDate];
  request.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  NSMutableArray *badRooms = [[NSMutableArray alloc] init];
  for (Reservation *reservation in results) {
    [badRooms addObject:reservation.room];
  }
  
  NSFetchRequest *finalRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *finalPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
  finalRequest.predicate = finalPredicate;
  
  NSError *finalError;
  
  NSArray *finalResults = [self.coreDataStack.managedObjectContext executeFetchRequest:finalRequest error:&finalError];
  
  if (finalError) {
    return nil;
  }
  return finalResults;
  
}

-(NSFetchedResultsController *)produceFetchedResultsControllerForAllReservations {
  
  NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSSortDescriptor *reservationSort = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:true];
  fetchRequest.sortDescriptors = @[reservationSort];
  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.coreDataStack.managedObjectContext sectionNameKeyPath:@"room.hotel.name" cacheName:@"AllReservationsCache"];
  
  return fetchedResultsController;
}

-(Reservation *)bookReservationForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  reservation.room = room;
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  guest.firstName = @"Randy";
  guest.lastName = @"Kitt";
  reservation.guest = guest;
  
  NSError *saveError;
  
  [self.coreDataStack.managedObjectContext save:&saveError];
  
  if (saveError) {
    return nil;
  }
  
  return reservation;
}

@end
