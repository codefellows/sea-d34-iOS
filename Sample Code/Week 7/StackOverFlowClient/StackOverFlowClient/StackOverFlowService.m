//
//  StackOverFlowService.m
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/12/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import "StackOverFlowService.h"
#import "AFNetworking.h"



@implementation StackOverFlowService

+(void)fetchQuestionsForSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray* items, NSString *error))completionHandler {
  
  NSString *url = [NSString stringWithFormat:@"%@search?order=desc&sort=activity&intitle=",SOURL];

  NSString *searchURL = [url stringByAppendingString:searchTerm];
  
  NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
  if (token) {
    searchURL = [searchURL stringByAppendingString:[NSString stringWithFormat:@"&access_token=%@",token]];
  }
  
  [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:searchURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    NSLog(@"%@",response);
    
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(nil,nil);
                   });
    
  }] resume];
  
}

@end
