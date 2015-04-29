//
//  ViewController.m
//  MyReminders
//
//  Created by Bradley Johnson on 4/27/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "AddRegionViewController.h"

const double kSeattleLat = 34;
const double kSeattleLong = 4324;

#define SEATT_LAT 34



@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regionAdded:) name:@"RegionAdded" object:nil];
  
  self.mapView.mapType = MKMapTypeSatellite;
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
  self.mapView.delegate = self;
  //_locationManager = [[CLLocationManager alloc] init];
  if ([CLLocationManager locationServicesEnabled]) {
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
      
      [self.locationManager requestAlwaysAuthorization];
      self.mapView.showsUserLocation = true;
    }
    
  }
  
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
  
  [self.mapView addGestureRecognizer:longPress];
  // Do any additional setup after loading the view, typically from a nib.
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
  
  if (longPress.state == UIGestureRecognizerStateBegan) {
  CGPoint locationInMap = [longPress locationInView:self.mapView];
 CLLocationCoordinate2D coordinate = [self.mapView convertPoint:locationInMap toCoordinateFromView:self.mapView];
    NSLog(@"%f, %f", coordinate.latitude, coordinate.longitude);
  
  MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
  annotation.coordinate = coordinate;
  annotation.title = @"Reminder";
  
  [self.mapView addAnnotation:annotation];
  }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  
  
  if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return nil;
  }
  
  MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
  
  if (!pinView) {
    pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    
    pinView.pinColor = MKPinAnnotationColorGreen;
    pinView.animatesDrop = true;
    pinView.canShowCallout = true;
    pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    pinView.draggable = true;
//    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePin:)];
//    [pinView addGestureRecognizer:pan];
    
  } else {
    pinView.annotation = annotation;
  }
  
  return pinView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
  
  
  
}





//-(void)movePin:(UIPanGestureRecognizer *)pan {
//  
//}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  NSLog(@"pressed!");
  
  CLLocationCoordinate2D coordinate = [view.annotation coordinate];
  
  AddRegionViewController *addRegionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddRegionVC"];
  addRegionVC.coordinate = coordinate;
  addRegionVC.locationManager = self.locationManager;
  [self presentViewController:addRegionVC animated:true completion:nil];
  
  

}
                                             
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  if (status == kCLAuthorizationStatusAuthorizedAlways) {
    self.mapView.showsUserLocation = true;
    //[self.locationManager startMonitoringSignificantLocationChanges];
  }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  CLLocation *firstLocation = locations.firstObject;
  NSLog(@"%f, %f", firstLocation.coordinate.latitude, firstLocation.coordinate.longitude);
}


-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  NSLog(@"entered Region!");
  UILocalNotification *notification = [[UILocalNotification alloc] init];
  //[notification setRegion:region];
  notification.alertTitle = @"hey you are here!";
  notification.alertAction = @"region launch";
  [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)seattlePressed:(id)sender {
  
  CLLocationCoordinate2D seattleCoordinate = CLLocationCoordinate2DMake(47.6097, -122.3331);
  
  [self.mapView setCenterCoordinate:seattleCoordinate animated:true];

}

-(void)regionAdded:(NSNotification *)notification {
  NSLog(@"region added from home!");
  NSDictionary *userInfo = notification.userInfo;
  CLCircularRegion *region = userInfo[@"region"];
  
  MKCircle *circle = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
  [self.mapView addOverlay:circle];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
  
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  
  circleRenderer.fillColor = [UIColor blueColor];
  circleRenderer.alpha = 0.5;
  circleRenderer.strokeColor = [UIColor purpleColor];
  

      return circleRenderer;
  
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
