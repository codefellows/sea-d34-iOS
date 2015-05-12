//
//  StackOverFlowService.h
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/12/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SOURL @"https://api.stackoverflow.com/2.2/"
#define kSearchEndpoint @"/search"
#define kNumberOfTags 31

@interface StackOverFlowService : NSObject

+(void)fetchQuestionsForSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray* items, NSString *error))completionHandler;


@end
