//
//  MenuSelectionDelegate.h
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/11/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuSelectionDelegate <NSObject>

-(void)userDidSelectOption:(NSInteger)selection;

@end
