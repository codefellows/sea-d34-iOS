//
//  SearchQuestionsViewController.m
//  StackOverFlowClient
//
//  Created by Bradley Johnson on 5/11/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "StackOverFlowService.h"

@interface SearchQuestionsViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.searchBar.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [StackOverFlowService fetchQuestionsForSearchTerm:searchBar.text completionHandler:^(NSArray *items, NSString *error) {

    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
      //download the image
      
      //
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
      //this code will run when the group of tasks is complete
    });
    
    
  }];
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
