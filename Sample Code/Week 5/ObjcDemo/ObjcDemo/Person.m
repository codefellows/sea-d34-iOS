//
//  Person.m
//  ObjcDemo
//
//  Created by Bradley Johnson on 4/27/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "Person.h"
#import "ViewController.h"

@implementation Person

-(instancetype)initWithName: (NSString *)name {
  if (self = [super init]) {
    _name = name;
  }
  return self;
}

@end
