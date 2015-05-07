//
//  CoreDataStack.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/6/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "CoreDataStack.h"
#import "Hotel.h"
#import "Room.h"

@interface CoreDataStack ()
@property (nonatomic) BOOL isForTesting;
@end

@implementation CoreDataStack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (instancetype)initForTesting {
  self = [super init];
  if (self) {
    self.isForTesting = true;
  }
  return self;
}

- (instancetype)init {
  self = [super init];
  if (self) {
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWillChangeStore:) name:NSPersistentStoreCoordinatorStoresWillChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidChangeStore:) name:NSPersistentStoreCoordinatorStoresDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangesToData:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSaveFromMainContext:) name:NSManagedObjectContextDidSaveNotification object:self.managedObjectContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSaveFromBackgroundContext:) name:NSManagedObjectContextDidSaveNotification object:self.backgroundContext];
    
    
  }
  return self;
}

-(void)handleSaveFromMainContext:(NSNotification *)notification {
  [self.backgroundContext performBlock:^{
    [self.backgroundContext mergeChangesFromContextDidSaveNotification:notification];
  }];
}

-(void)handleSaveFromBackgroundContext:(NSNotification *)notification {
  [self.managedObjectContext performBlock:^{
    [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
  }];
}

  

-(void)handleWillChangeStore:(NSNotification *)notification {
  NSLog(@"will change store");
  
  [self.managedObjectContext performBlock:^{
    
    if ([self.managedObjectContext hasChanges]) {
      NSError *saveError;
      [self.managedObjectContext save:&saveError];
      if (saveError) {
        NSLog(@"%@",saveError);
      }
    }
    
    [self.managedObjectContext reset];
    
  } ];
}

-(void)handleDidChangeStore:(NSNotification *)notification {
  NSLog(@"did change store");
}

-(void)handleChangesToData:(NSNotification *)notification {
  NSLog(@"new data");
  
  [self.managedObjectContext performBlock:^{
    [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DataChanged" object:nil];
    
  }];
}

- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "BPJ.HotelManager" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HotelManager" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  // Create the coordinator and store
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HotelManager.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  NSString *storeType;
  if (self.isForTesting) {
    storeType = NSInMemoryStoreType;
  } else {
    storeType = NSSQLiteStoreType;
  }
  
  NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @true, NSInferMappingModelAutomaticallyOption : @true,NSPersistentStoreUbiquitousContentNameKey : @"HoteliCloud", NSPersistentStoreUbiquitousContentURLKey : [self cloudDirectory]};
  
  
  if (![_persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    // Replace this with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
  return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
  // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    return nil;
  }
  _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  self.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  self.backgroundContext.persistentStoreCoordinator = coordinator;
  
  
  return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

-(NSURL *)cloudDirectory
{
  NSFileManager *fileManager=[NSFileManager defaultManager];
  NSURL *cloudRootURL=[fileManager URLForUbiquityContainerIdentifier:nil];
  NSLog (@"cloudRootURL=%@",cloudRootURL);
  return cloudRootURL;
}

-(void)seedDataBaseIfNeeded {
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
  NSError *fetchError;
  
  NSInteger results = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
  NSLog(@" %ld", (long)results);
  if (results == 0) {
    NSURL *seedURL = [[NSBundle mainBundle] URLForResource:@"seed" withExtension:@"json"];
    NSData *seedData = [[NSData alloc] initWithContentsOfURL:seedURL];
    NSError *jsonError;
    NSDictionary *rootDictionary = [NSJSONSerialization JSONObjectWithData:seedData options:0 error:&jsonError];
    if (!jsonError) {
      NSArray *jsonArray = rootDictionary[@"Hotels"];
      
      for (NSDictionary *hotelDictionary in jsonArray) {
        Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
        hotel.name = hotelDictionary[@"name"];
        hotel.location = hotelDictionary[@"location"];
        
        NSArray *roomsArray = hotelDictionary[@"rooms"];
        for (NSDictionary *roomDictionary in roomsArray) {
          Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
          room.number = roomDictionary[@"number"];
          room.rate = roomDictionary[@"rate"];
          room.hotel = hotel;
        }
      }
      
      NSError *saveError;
      [self.managedObjectContext save:&saveError];
      
      if (saveError) {
        NSLog(@"%@",saveError.localizedDescription);
      }
    }
  }
  
}


@end
