//
//  MainMenuTableViewController.m
//  HotelManager
//
//  Created by Bradley Johnson on 5/7/15.
//  Copyright (c) 2015 BradJohnson. All rights reserved.
//

#import "MainMenuTableViewController.h"
#import "HotelListViewController.h"
#import "FromDateViewController.h"

@interface MainMenuTableViewController ()

@property (strong,nonatomic) NSArray *options;

@end

@implementation MainMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.options = @[@"All Hotels",@"Availability"];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"OptionCell"];
  
  NSArray *stuff = @[@34,@523,@2,@5,@134];
  
  [stuff enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    
  }];
  
  [stuff sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    return (obj1>obj2);
  }];
  
  
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
  return self.options.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
  NSString *option = self.options[indexPath.row];
  cell.textLabel.text = option;
  
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  switch (indexPath.row) {
    case 0: {
       HotelListViewController *hotelListVC = [[HotelListViewController alloc] init];
      [self.navigationController pushViewController:hotelListVC animated:true];
    }
      break;
    case 1: {
      FromDateViewController *fromDateVC = [[FromDateViewController alloc] init];
      [self.navigationController pushViewController:fromDateVC animated:true];
    }
    default:
      break;
  }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
