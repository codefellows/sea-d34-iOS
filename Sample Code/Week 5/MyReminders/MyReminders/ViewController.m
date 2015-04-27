//
//  ViewController.m
//  MyReminders
//
//  Created by Bradley Johnson on 4/27/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.mapView.mapType = MKMapTypeSatellite;
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)seattlePressed:(id)sender {
  
  CLLocationCoordinate2D seattleCoordinate = CLLocationCoordinate2DMake(47.6097, -122.3331);
  
  [self.mapView setCenterCoordinate:seattleCoordinate animated:true];

}

@end
