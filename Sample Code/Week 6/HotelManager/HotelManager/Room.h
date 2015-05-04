//
//  Room.h
//  
//
//  Created by Bradley Johnson on 5/4/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel;

@interface Room : NSManagedObject

@property (nonatomic) int16_t number;
@property (nonatomic, retain) NSDecimalNumber * rate;
@property (nonatomic, retain) Hotel *hotel;

@end
