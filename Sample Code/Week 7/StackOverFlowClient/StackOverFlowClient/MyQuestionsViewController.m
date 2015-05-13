//
//  MyQuestionsViewController.m
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/11/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import "MyQuestionsViewController.h"
#import "AFNetworking.h"

@interface MyQuestionsViewController ()

@end

@implementation MyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  NSLog(@"%lu",(unsigned long)[NSURLCache sharedURLCache].diskCapacity);
  
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://avatars.githubusercontent.com/u/325742?v=3"]];
  
  NSURLRequest *newRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://avatars.githubusercontent.com/u/325742?v=3"] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:100];
  
  
  AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:newRequest];
  requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
  [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"Response: %@", responseObject);
    NSLog(@"Response: %@",operation);
    UIImage *image = (UIImage *)responseObject;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
      imageView.image = image;
      [self.view addSubview:imageView];
    }];
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Image error: %@", error);
  }];
  [requestOperation start];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
