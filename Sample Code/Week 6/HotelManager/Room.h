//
//  Room.h
//  HotelManager
//
//  Created by Bradley Johnson on 5/5/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSDecimalNumber * rate;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * beds;
@property (nonatomic, retain) Hotel *hotel;
@property (nonatomic, retain) NSSet *reservations;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservation *)value;
- (void)removeReservationsObject:(Reservation *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;

@end
