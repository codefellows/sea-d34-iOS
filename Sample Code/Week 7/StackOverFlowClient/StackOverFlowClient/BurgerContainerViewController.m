//
//  BurgerContainerViewController.m
//  
//
//  Created by Bradley Johnson on 5/11/15.
//
//

#import "BurgerContainerViewController.h"
#import "MainMenuTableViewController.h"
#import "SearchQuestionsViewController.h"
#import "MenuSelectionDelegate.h"
#import "MyQuestionsViewController.h"

@interface BurgerContainerViewController () <MenuSelectionDelegate>

@property (strong,nonatomic) UIPanGestureRecognizer *slideGesture;
@property (strong,nonatomic) UIViewController *topViewController;
@property (strong,nonatomic) UITapGestureRecognizer *tapToClose;
@property (strong,nonatomic) UIButton *burgerButton;
@property (strong,nonatomic) MyQuestionsViewController *myQuestionsVC;
@property (strong,nonatomic) SearchQuestionsViewController *searchQuestionsVC;

@end

@implementation BurgerContainerViewController

@synthesize myQuestionsVC = _myQuestionsVC;

NSInteger const slideRightBuffer = 250;

- (void)viewDidLoad {
    [super viewDidLoad];
  
  MainMenuTableViewController *mainMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuVC"];
  [self addChildViewController:mainMenuVC];
  mainMenuVC.view.frame = self.view.frame;
  [self.view addSubview:mainMenuVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  mainMenuVC.delegate = self;
  
  SearchQuestionsViewController *searchQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchQuestionsVC"];
  [self addChildViewController:searchQuestionsVC];
  searchQuestionsVC.view.frame = self.view.frame;
  [self.view addSubview:searchQuestionsVC.view];
  [searchQuestionsVC didMoveToParentViewController:self];
  self.topViewController = searchQuestionsVC;
  self.searchQuestionsVC = searchQuestionsVC;
  
  self.slideGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slidePanel:)];
  [self.topViewController.view addGestureRecognizer:self.slideGesture];
  
  UIButton *burgerButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 16, 75, 75)];
  [burgerButton setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
  [burgerButton addTarget:self action:@selector(burgerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.topViewController.view addSubview:burgerButton];
  self.burgerButton = burgerButton;
  
  self.tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedForClose)];
  
  
   
    // Do any additional setup after loading the view.
}

-(void)slidePanel:(UIPanGestureRecognizer *)pan {
  CGPoint translatedPoint = [pan translationInView:self.view];
  CGPoint velocity = [pan velocityInView:self.view];
  
  if (pan.state == UIGestureRecognizerStateChanged) {
    
    if (velocity.x > 0 || self.topViewController.view.frame.origin.x > 0) {
    self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translatedPoint.x, self.topViewController.view.center.y);
    [pan setTranslation:CGPointZero inView:self.view];
    }
  }
  
  if (pan.state == UIGestureRecognizerStateEnded) {
    
    if (self.topViewController.view.frame.origin.x > self.view.frame.size.width / 3) {
      self.burgerButton.userInteractionEnabled = false;
      [UIView animateWithDuration:0.3 animations:^{
        self.topViewController.view.frame = CGRectMake(self.view.frame.size.width * 0.75, 0, self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
        
//           self.topViewController.view.center = CGPointMake(, self.topViewController.view.center.y);
      } completion:^(BOOL finished) {
        [self.topViewController.view addGestureRecognizer:self.tapToClose];
      }];
      
    } else {
      
      [UIView animateWithDuration:0.2 animations:^{
        self.topViewController.view.center = self.view.center;
      } completion:^(BOOL finished) {
        self.burgerButton.userInteractionEnabled = true;
      }];
    }
  }
  
}

-(void)burgerButtonPressed {
  self.burgerButton.userInteractionEnabled = false;
  [UIView animateWithDuration:0.3 animations:^{
      self.topViewController.view.frame = CGRectMake(self.view.frame.size.width * 0.75, 0, self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
  } completion:^(BOOL finished) {
    
    [self.topViewController.view addGestureRecognizer:self.tapToClose];
    
  }];
}

-(void)tappedForClose {
  
  [self.topViewController.view removeGestureRecognizer:self.tapToClose];
  
  [UIView animateWithDuration:0.3 animations:^{
    self.topViewController.view.center = self.view.center;
  } completion:^(BOOL finished) {
    self.burgerButton.userInteractionEnabled = true;
  }];
  
}

-(void)userDidSelectOption:(NSInteger)selection {
  if (selection == 0) {
    if (self.topViewController != self.searchQuestionsVC) {
    [self switchToViewController:self.searchQuestionsVC];
      return;
    }
  }
  if (selection == 1) {
    if (self.topViewController != self.myQuestionsVC) {
    [self switchToViewController:self.myQuestionsVC];
      return;
    }
  }
  
  [UIView animateWithDuration:0.3 animations:^{
    self.topViewController.view.center = self.view.center;
  } completion:^(BOOL finished) {
    self.burgerButton.userInteractionEnabled = true;
  }];
  
}

-(void)switchToViewController:(UIViewController *)destinationVC {
  
  [UIView animateWithDuration:0.2 animations:^{
    
    self.topViewController.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    
  } completion:^(BOOL finished) {
    destinationVC.view.frame = self.topViewController.view.frame;
    
    [self.topViewController.view removeGestureRecognizer:self.slideGesture];
    [self.burgerButton removeFromSuperview];
    [self.topViewController willMoveToParentViewController:nil];
    [self.topViewController.view removeFromSuperview];
    [self.topViewController removeFromParentViewController];
    
    self.topViewController = destinationVC;
    [self addChildViewController:self.topViewController];
    [self.view addSubview:self.topViewController.view];
    [self.topViewController didMoveToParentViewController:self];
    [self.topViewController.view addSubview:self.burgerButton];
    [self.topViewController.view addGestureRecognizer:self.slideGesture];
    
    [UIView animateWithDuration:0.3 animations:^{
      self.topViewController.view.center = self.view.center;
    } completion:^(BOOL finished) {
      self.burgerButton.userInteractionEnabled = true;
    }];
    
  }];
  
}

-(MyQuestionsViewController *)myQuestionsVC {
  
  if (_myQuestionsVC != nil) {
    return _myQuestionsVC;
  }
  
  _myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsVC"];
  return _myQuestionsVC;
}

-(void)setMyQuestionsVC:(MyQuestionsViewController *)myQuestionsVC {
  _myQuestionsVC = myQuestionsVC;
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
