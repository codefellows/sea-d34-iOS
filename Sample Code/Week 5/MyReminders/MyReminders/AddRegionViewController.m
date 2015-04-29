//
//  AddRegionViewController.m
//  MyReminders
//
//  Created by Bradley Johnson on 4/29/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "AddRegionViewController.h"

@interface AddRegionViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation AddRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return true;
}
- (IBAction)addRegionPressed:(id)sender {
  
  if ( [CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:self.coordinate radius:200 identifier:self.textField.text];
    [self.locationManager startMonitoringForRegion:region];
    
    NSDictionary *userInfo = @{@"region" : region};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegionAdded" object:self userInfo:userInfo];
    
    [self dismissViewControllerAnimated:true completion:nil];
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
