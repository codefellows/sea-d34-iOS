//
//  Hotel.h
//  
//
//  Created by Bradley Johnson on 5/4/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Hotel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSSet *rooms;
@end

@interface Hotel (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(NSManagedObject *)value;
- (void)removeRoomsObject:(NSManagedObject *)value;
- (void)addRooms:(NSSet *)values;
- (void)removeRooms:(NSSet *)values;

@end
