//
//  CSSearchLocationViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/19/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSSearchLocationViewController.h"
#import "CSSharedData.h"
#import "CSAddEventViewController.h"

@interface CSSearchLocationViewController ()

@end

@implementation CSSearchLocationViewController {
    
    UITableView *locationsTable;
    NSMutableArray *objects;
    int page;
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    page = 1;
    locationsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    locationsTable.delegate = self;
    locationsTable.dataSource = self;
    locationsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:locationsTable];
    
    objects = [[NSMutableArray alloc] init];
    
    [DejalBezelActivityView activityViewForView:self.view];

    
    [[CSSharedData sharedInstance] setCurrentCity:@"Everett"];
    [self loadDataView];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    
    locationsTable.tableHeaderView = searchBar;
}
-(void)loadDataView {
    
    objects = [[CSSharedData sharedInstance] nearLocations];
    [locationsTable reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = [objects count];
    return numberOfRows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    }
    CSLocation *location = [objects objectAtIndex:indexPath.row];
    cell.textLabel.text = location.name;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CSLocation *location = [objects objectAtIndex:indexPath.row];
    CSAddEventViewController *goView  = [self.navigationController.viewControllers objectAtIndex:0];
    goView.labelLocation.text = location.name;
    goView.selectedIdLocation =  location.id;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
