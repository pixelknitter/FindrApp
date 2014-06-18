//
//  SearchViewController.m
//  Findr
//
//  Created by Eddie Freeman on 6/13/14.
//  Copyright (c) 2014 NinjaSudo Inc. All rights reserved.
//

#import "SearchViewController.h"
#import "FilterViewController.h"
#import "PlaceCell.h"
#import "MBProgressHud.h"
#import "YelpManager.h"
#import "TSMessage.h"
#import "Utils.h"

CGFloat inset = 15.f;

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *announcementView;

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UIBarButtonItem *filterButton;
@property (strong, nonatomic) NSArray *places;
@property (strong, nonatomic) UIView *progressView;
@property (strong, nonatomic) PlaceCell *stubCell;

- (void)selectFilter:(id)sender;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Set up data storage
    
    // Set up TSMessage Defaults
    [TSMessage setDefaultViewController:self];
    [TSMessage iOS7StyleEnabled];
  }
  return self;
}

- (void)viewWillAppear:(BOOL)state {
  [super viewWillAppear:state];
  
  if([[YelpManager sharedManager] updateFilters]) {
    [self fetchData];
    [YelpManager sharedManager].updateFilters = NO;
    NSLog(@"Updating Search with Filters");
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Add Filter Button
  self.filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(selectFilter:)];
  
  // TODO couldn't get this working.
//  self.filterButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FilterIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(selectFilter:)];
  
  self.navigationItem.leftBarButtonItem = self.filterButton;
  
  CGFloat searchWidth = self.view.frame.size.width - (inset*2) - (self.navigationItem.leftBarButtonItem.width + self.navigationItem.rightBarButtonItem.width);
  
  // Set Up Search Bar
  self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, searchWidth, 44.0)];
  self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  [self.searchBar setKeyboardType:UIKeyboardTypeWebSearch];
  [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeWords];
  [self.searchBar setBarTintColor:[UIColor redColor]];
  [self.searchBar setTintColor:[UIColor blackColor]];
  
  self.navigationItem.titleView = self.searchBar;
  
  self.searchBar.delegate = self;
  
  [TSMessage showNotificationInViewController:self title:@"Findr" subtitle:@"Search Above" type:TSMessageNotificationTypeMessage duration:1.f];
//  NSString *startText = @"Thai";
//  self.searchBar.text = startText;
//  [self fetchData];
  // Set Up Table View
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  UINib *cellNib = [UINib nibWithNibName:@"PlaceCell" bundle:nil];
  [self.tableView registerNib:cellNib forCellReuseIdentifier:@"PlaceCell"];
  
  self.stubCell = [cellNib instantiateWithOwner:nil options:nil][0];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [self.places count];
}

- (void)configureCell:(PlaceCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
  Restaraunt *place = self.places[indexPath.row];
  cell.placeNameLabel.text = place.name;
  
  
  cell.addressLabel.text = place.displayAddress;
  [Utils loadImageUrl:place.imageURL inImageView:cell.placeImageView withAnimation:YES];
  [Utils loadImageUrl:place.ratingImageURL inImageView:cell.ratingImageView withAnimation:YES];
  cell.reviewCountLabel.text = [[NSString alloc] initWithFormat:@"%d reviews", place.reviewCount];
  cell.categoriesLabel.text = place.categories;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  [self configureCell:self.stubCell atIndexPath:indexPath];
  [self.stubCell layoutSubviews];
  
  CGSize size = [self.stubCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  return size.height + 1;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//  return UITableViewAutomaticDimension;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell" forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

# pragma mark - Search Bar Delegate

//- (BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar {
//  return YES;
//}

//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//  NSLog(@"search bar did end");
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [searchBar resignFirstResponder];
  [self fetchData];
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
  
  return YES;
}

- (BOOL) searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  
  return YES;
}
#pragma mark - TableView Delegate



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
 
 // TODO, will likely need this for filters and animated search changes
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

#pragma mark - Data

- (void)fetchData {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  
  [[YelpManager sharedManager] searchWithTerm:self.searchBar.text filters:NO success:^(AFHTTPRequestOperation *operation, id response) {
    self.places = [Restaraunt placesWithArray:response[@"businesses"]];
//    NSLog(@"%@", response);
    if(![self.places count]) { // If no length
      [TSMessage showNotificationInViewController:self
                                            title:@"Oops, No Data!"
                                            subtitle:@"Try refining your search..."
                                            type:TSMessageNotificationTypeWarning
                                            duration:1.f];
    }
    [self.tableView reloadData];
    // hide HUD
    [MBProgressHUD hideHUDForView:self.view animated:YES];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"error: %@", [error description]);
    // Add Network Error
    [TSMessage showNotificationInViewController:self
                                          title:@"Network Error!"
                                       subtitle:@"Please try again in a few..."
                                           type:TSMessageNotificationTypeError
                                       duration:1.f];
    
//    [TSMessage showNotificationInViewController:<#(UIViewController *)#> title:<#(NSString *)#> subtitle:<#(NSString *)#> image:<#(UIImage *)#> type:<#(TSMessageNotificationType)#> duration:<#(NSTimeInterval)#> callback:<#^(void)callback#> buttonTitle:@"Again" buttonCallback:^{
//    }atPosition:TSMessageNotificationPositionTop canBeDismissedByUser:YES]
    self.searchBar.hidden = YES;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
  }];
  
  // Go back to Top of TableView
  [self.tableView scrollRectToVisible:CGRectMake(0, 0, self.tableView.frame.size.width, 10) animated:NO];
}

#pragma mark - Button Selectors

- (void)selectFilter:(id)sender {
  FilterViewController *filterViewController = [[FilterViewController alloc] initWithNibName:nil bundle:nil];
  
  [self.navigationController pushViewController:filterViewController animated:YES];
}

@end
