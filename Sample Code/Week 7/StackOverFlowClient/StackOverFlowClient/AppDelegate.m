//
//  AppDelegate.m
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/11/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import "AppDelegate.h"
#import "BurgerContainerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:100 * 1024 * 1024 diskCapacity:100 * 1024 * 1024 diskPath:nil];
  [NSURLCache setSharedURLCache:sharedCache];

  
  
//  dispatch_queue_t myQueue = dispatch_queue_create(NULL, NULL);
//  
//  dispatch_async(myQueue, ^{
//    
//  //image download
//    NSLog(@"hello");
//    
//    dispatch_sync(myQueue, ^{
//      // do something else
//       NSLog(@"hello 2");
//    });
//    
//  });
  
  NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
  if (token) {
    
    NSLog(@"%@",[self.window.rootViewController class]);
    UIStoryboard *storyboard = self.window.rootViewController.storyboard;
    BurgerContainerViewController *burgerContainerVC = [storyboard instantiateViewControllerWithIdentifier:@"BurgerContainerVC"];
    self.window.rootViewController = burgerContainerVC;
    
  }

  
  // Override point for customization after application launch.
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
}

@end
