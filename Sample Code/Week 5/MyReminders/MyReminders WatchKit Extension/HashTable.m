//
//  HashTable.m
//  MyReminders
//
//  Created by Bradley Johnson on 4/30/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "HashTable.h"
#import "Bucket.h"

@interface HashTable  ()

@property (strong,nonatomic) NSMutableArray *items;
@property (nonatomic) NSInteger size;
@property (nonatomic) NSInteger count;


@end

@implementation HashTable

-(instancetype)initWithSize:(NSInteger)size {
  self = [super init];
  if (self) {
    self.size = size;
    
    for (int i = 0; i < size; i++) {
      Bucket *bucket = [[Bucket alloc] init];
      [self.items addObject:bucket];
    }
  }
  return self;
}

-(NSInteger)hash:(NSString *)key {
  
  NSInteger total = 0;
  
  for (int i = 0; i < key.length; i++) {
    NSInteger ascii = [key characterAtIndex:i];
    total = total + ascii;
  }
  return total % self.size;
  
}

-(void)addObject:(id)object forKey:(NSString *)key {
  
  [self removeObjectForKey:key];
  
  NSInteger index = [self hash:key];
  
  Bucket *bucket = self.items[index];
  
  if (!bucket.key) {
    bucket.key = key;
    bucket.data = object;
  } else {
    Bucket *newBucket = [[Bucket alloc] init];
    newBucket.key = key;
    newBucket.data = object;
    newBucket.next = bucket;
    self.items[index] = newBucket;
  }
}

-(id)objectForKey:(NSString *)key {
  NSInteger index = [self hash:key];
  
  Bucket *bucket = self.items[index];
  
  while (bucket) {
    if ([bucket.key isEqualToString:key]) {
      return bucket.data;
    }
    bucket = bucket.next;
  }
  return nil;
}

-(void)removeObjectForKey:(NSString *)key {
  NSInteger index = [self hash:key];
  Bucket *bucket = self.items[index];
  Bucket *previousBucket;
  
  while (bucket) {
    if ([bucket.key isEqualToString:key]) {
      if (!previousBucket) {
        if (!bucket.next) {
          bucket.key = nil;
          bucket.data = nil;
        } else {
          self.items[index] = bucket.next;
        }
      } else {
        previousBucket.next = bucket.next;
      }
    }
    previousBucket = bucket;
    bucket = bucket.next;
  }
  
}

@end
