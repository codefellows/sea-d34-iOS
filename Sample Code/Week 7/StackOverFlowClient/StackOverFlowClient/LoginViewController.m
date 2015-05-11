//
//  LoginViewController.m
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/11/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import "LoginViewController.h"
#import "OAuthWebViewController.h"

@interface LoginViewController ()

@property (strong,nonatomic) UIDynamicAnimator *animator;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  redView.backgroundColor = [UIColor redColor];
  [self.view addSubview:redView];
  
  UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(150, 0, 100, 100)];
  blueView.backgroundColor = [UIColor blueColor];
  [self.view addSubview:blueView];
  
  UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:redView attachedToItem:blueView];
  
  attachment.length = 50;
  
  UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
  [gravity addItem:redView];
  
  UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
  [collision setTranslatesReferenceBoundsIntoBoundary:true];
  [collision addItem:redView];
  
  [self.animator addBehavior:collision];
  [self.animator addBehavior:gravity];
  [self.animator addBehavior:attachment];
    // Do any additional setup after loading the view.
}
- (IBAction)loginButtonPressed:(id)sender {
  OAuthWebViewController *webVC = [[OAuthWebViewController alloc] init];
  webVC.view.frame = self.view.frame;
  webVC.view.backgroundColor = [UIColor greenColor];
  
  [self presentViewController:webVC animated:true completion:^{
    
  }];
}

- (UIDynamicAnimator *)animator {
  if (_animator != nil ) {
    return _animator;
  }
  _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
  return _animator;
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
