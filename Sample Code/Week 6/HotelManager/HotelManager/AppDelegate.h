//
//  AppDelegate.h
//  HotelManager
//
//  Created by Bradley Johnson on 5/4/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HotelService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly,strong,nonatomic) HotelService *hotelService;
@property (strong, nonatomic) UIWindow *window;



@end

