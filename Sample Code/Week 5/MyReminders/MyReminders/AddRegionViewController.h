//
//  AddRegionViewController.h
//  MyReminders
//
//  Created by Bradley Johnson on 4/29/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddRegionViewController : UIViewController


@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong,nonatomic) CLLocationManager *locationManager;

@end
