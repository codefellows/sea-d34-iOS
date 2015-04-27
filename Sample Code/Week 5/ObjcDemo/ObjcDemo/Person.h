//
//  Person.h
//  ObjcDemo
//
//  Created by Bradley Johnson on 4/27/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ViewController;

@interface Person : NSObject

@property (strong,nonatomic) ViewController *myVC;
@property (strong,nonatomic) NSString* name;
-(instancetype)initWithName: (NSString *)name;

@end
