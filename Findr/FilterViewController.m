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
#import "SeeAllTableViewCell.h"
#import "ToggleFilterCell.h"

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterView;
@property (strong, nonatomic) UIBarButtonItem *searchButton;

- (void)searchWithFilters:(id)sender;

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
  
  // Add Search Button
  self.searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchWithFilters:)];
  //  self.filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FilterIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(selectFilter:)];
  
  self.navigationItem.rightBarButtonItem = self.searchButton;
  
  self.title = @"Filters";
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  UINib *filterCellNib = [UINib nibWithNibName:@"ToggleFilterCell" bundle:nil];
  [self.tableView registerNib:filterCellNib forCellReuseIdentifier:@"FilterCell"];
  UINib *seeAllNib = [UINib nibWithNibName:@"SeeAllTableViewCell" bundle:nil];
  [self.tableView registerNib:seeAllNib forCellReuseIdentifier:@"SeeAllCell"];
  
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
  
  FilterGroup *filterGroup = [[YelpManager sharedManager] getFilterGroupForSection:indexPath.section];
  int currentRow;
  if (filterGroup.isCollapsed && !(filterGroup.hasMany)) {
    currentRow = filterGroup.selectedRow;
  } else {
    currentRow = indexPath.row;
  }
  
  if (filterGroup.isCollapsed && filterGroup.hasMany && (currentRow > (filterGroup.rowsWhenCollapsed - 1))) {
    SeeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeeAllCell"];
    return cell;
  } else {
    ToggleFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
    Filter *filter = filterGroup.filters[currentRow];
    cell.filter = filter;
    return cell;
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
  return 30.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  FilterGroup *filterGroup = [[YelpManager sharedManager] getFilterGroupForSection:indexPath.section];
  
  [filterGroup toggleCollapsed:indexPath.row];
  [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Search

- (void)searchWithFilters:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
  [YelpManager sharedManager].updateFilters = YES;
//  [YelpManager sharedManager] setFilters:];
}

@end
