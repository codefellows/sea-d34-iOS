//
//  AppDelegate.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/4/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Hotel.h"
#import "HotelListViewController.h"
#import "Room.h"
#import "FromDateViewController.h"
#import "CoreDataStack.h"
#import "ReservationListViewController.h"
#import "MainMenuTableViewController.h"

@interface AppDelegate ()

@property (readwrite,strong,nonatomic) HotelService *hotelService;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window makeKeyAndVisible];
  
  CoreDataStack *coreDataStack = [[CoreDataStack alloc] init];
  self.hotelService = [[HotelService alloc] initWithCoreDataStack:coreDataStack];
  
  //[coreDataStack seedDataBaseIfNeeded];
  
  
  HotelListViewController *hotelVC = [[HotelListViewController alloc] init];
  FromDateViewController *fromDateVC = [[FromDateViewController alloc] init];
  MainMenuTableViewController *mainMenuVC = [[MainMenuTableViewController alloc] init];
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainMenuVC];
  ReservationListViewController *reservationListVC = [[ReservationListViewController alloc] init];
  self.window.rootViewController = navController;
 
  
//  Hotel *hotel = (Hotel*)results.firstObject;
//  NSLog(@"%lu",(unsigned long)hotel.rooms.count);
//  
//  Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
//  hotel.name = @"Okay Motel";
//  hotel.location = @"Lynnwood";
//  
//  Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
//  room.number = 302;
//  room.rate = [[NSDecimalNumber alloc] initWithDouble:150.00];
//  room.hotel = hotel;


//
//  NSError *saveError;
//  
//  [self.managedObjectContext save:&saveError];
//  if (saveError) {
//    NSLog(@"%@",saveError.localizedDescription);
//  }
  
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  // Saves changes in the application's managed object context before the application terminates.
}


@end
