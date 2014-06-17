//
//  FilterViewController.m
//  Findr
//
//  Created by Eddie Freeman on 6/13/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import "FilterViewController.h"
#import "YelpManager.h"
#import "FilterGroup.h"
#import "Filter.h"

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterView;

@end

@implementation FilterViewController

// Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"Filters";
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  // Uncomment the following line to preserve selection between presentations.
  self.clearsSelectionOnViewWillAppear = NO;
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[[YelpManager sharedManager] filterGroups] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  int rows;
  FilterGroup *filterGroup = [[YelpManager sharedManager] getFilterGroupForSection:section];
  if (filterGroup.isExpandable && filterGroup.isCollapsed) {
    rows = [filterGroup displayRowsWhenCollapsed];
  } else {
    rows = [filterGroup.filters count];
  }
  return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  
  // XXX clean this up so the filter value can export a view or something
  FilterGroup *filterGroup = [[YelpManager sharedManager] getFilterGroupForSection:indexPath.section];
  NSInteger currentRow;
  if (filterGroup.isCollapsed && !(filterGroup.hasMany)) {
    currentRow = filterGroup.selectedRow;
  } else {
    currentRow = indexPath.row;
  }
  
  if (filterGroup.isCollapsed && filterGroup.hasMany && (currentRow > (filterGroup.rowsWhenCollapsed - 1))) {
    cell.textLabel.text = @"See All";
  } else {
    Filter *filterValue = filterGroup.filters[currentRow];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", filterValue.label];
  }
  
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  FilterGroup *filter = [[YelpManager sharedManager] getFilterGroupForSection:section];
  
  // XXX clean this up so we use a custom title view
  CGRect titleView = self.tableView.frame;
  titleView.size.height = 30;
  
  UIView *view = [[UIView alloc] initWithFrame:titleView];
  view.backgroundColor = [UIColor redColor];
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView];
  titleLabel.text = filter.label;
  titleLabel.textColor = [UIColor whiteColor];
  [view addSubview:titleLabel];
  
  return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  FilterGroup *filterGroup = [[YelpManager sharedManager] getFilterGroupForSection:indexPath.section];
  
  [filterGroup toggleCollapsed:indexPath.row];
  [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
