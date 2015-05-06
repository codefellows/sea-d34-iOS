//
//  HotelListViewController.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/4/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "HotelListViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Hotel.h"

@interface HotelListViewController () <UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *hotels;

@end

@implementation HotelListViewController

-(void)loadView {
  UIView *rootView = [[UIView alloc] init];
  
  self.tableView = [[UITableView alloc] init];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.tableView];
  
  [self addConstraintsToRootView:rootView withViews:@{@"tableView" : self.tableView}];
  
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  HotelService *hotelService = appDelegate.hotelService;
  
  self.hotels = [hotelService fetchAllHotels];
  
      [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];
  self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell"forIndexPath:indexPath];
  Hotel *hotel = self.hotels[indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}

-(void)addConstraintsToRootView:(UIView *)rootView withViews:(NSDictionary *)views {
  
  NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVertical];
  NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontal];
  
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
