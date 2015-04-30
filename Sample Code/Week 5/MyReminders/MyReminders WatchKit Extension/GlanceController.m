//
//  GlanceController.m
//  MyReminders WatchKit Extension
//
//  Created by Bradley Johnson on 4/30/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "GlanceController.h"
#import <CoreLocation/CoreLocation.h>


@interface GlanceController()
@property (strong,nonatomic) NSArray *regions;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *numberLabel;

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
  
  CLLocationManager *manager = [[CLLocationManager alloc] init];
  
  self.regions = manager.monitoredRegions.allObjects;
  
  NSString *numberString = [NSString stringWithFormat:@"%lu",(unsigned long)self.regions.count];
  
  [self.numberLabel setText:numberString];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



