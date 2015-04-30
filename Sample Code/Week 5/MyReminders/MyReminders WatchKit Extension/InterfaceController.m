//
//  InterfaceController.m
//  MyReminders WatchKit Extension
//
//  Created by Bradley Johnson on 4/30/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "InterfaceController.h"
#import "RegionRowController.h"
#import <CoreLocation/CoreLocation.h>

@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;
@property (strong,nonatomic) NSArray *names;
@property (strong,nonatomic) NSArray *regions;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
  
  self.names = @[@"Russell", @"Richard", @"Rivers",@"Pete",@"Kam"];
  CLLocationManager *manager = [[CLLocationManager alloc] init];
  
  self.regions = manager.monitoredRegions.allObjects;
  
  
  [self.table setNumberOfRows:self.regions.count withRowType:@"Region"];
  
  
  for (CLRegion *region in self.regions) {
    NSInteger index = [self.regions indexOfObject:region];
    RegionRowController *regionController = [self.table rowControllerAtIndex:index];
    regionController.regionLabel.text = region.identifier;
  }
  [WKInterfaceController openParentApplication:nil reply:^(NSDictionary *replyInfo, NSError *error) {
    
  }];

  

    // Configure interface objects here.
}

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
//  [self pushControllerWithName:<#(NSString *)#> context:<#(id)#>]
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



