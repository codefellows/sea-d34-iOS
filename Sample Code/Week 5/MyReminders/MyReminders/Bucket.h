//
//  Bucket.h
//  MyReminders
//
//  Created by Bradley Johnson on 4/30/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bucket : NSObject

@property (strong,nonatomic) Bucket *next;
@property (strong, nonatomic) NSString *key;
@property (strong,nonatomic) id data;


@end
