//
//  OAuthWebViewController.m
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/11/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import "OAuthWebViewController.h"
#import <WebKit/WebKit.h>

@interface OAuthWebViewController () <WKNavigationDelegate>

@property (strong,nonatomic) WKWebView *webView;

@end

@implementation OAuthWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.webView = [[WKWebView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:self.webView];
  self.webView.navigationDelegate = self;
  
  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://stackexchange.com/oauth/dialog?client_id=3197&scope=no_expiry&redirect_uri=https://stackexchange.com/oauth/login_success"]]];
  // Do any additional setup after loading the view.
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  NSURLRequest *request = navigationAction.request;
  NSURL *url = request.URL;
  NSLog(@"%@",url);
  decisionHandler(WKNavigationActionPolicyAllow);
  
  if ([url.description containsString:@"access_token"]) {
    NSArray *components = [[url description] componentsSeparatedByString:@"="];
    NSString *token = components.lastObject;
    NSLog(@"%@",token);
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:true completion:^{
      
    }];
    
  }
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
