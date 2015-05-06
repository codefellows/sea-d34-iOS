//
//  AvailabilityTableViewController.h
//  HotelManager
//
//  Created by Bradley Johnson on 5/5/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailabilityTableViewController : UITableViewController

@property (strong,nonatomic) NSDate *fromDate;
@property (strong,nonatomic) NSDate *toDate;

@end
