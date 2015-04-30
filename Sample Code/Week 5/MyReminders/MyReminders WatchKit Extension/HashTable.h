//
//  HashTable.h
//  MyReminders
//
//  Created by Bradley Johnson on 4/30/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject

-(instancetype)initWithSize:(NSInteger)size;
-(void)addObject:(id)object forKey:(NSString *)key;
-(void)removeObjectForKey:(NSString *)key;
-(id)objectForKey:(NSString *)key;

@end
