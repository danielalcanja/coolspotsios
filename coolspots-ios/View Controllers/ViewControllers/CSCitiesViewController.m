//
//  CSCitiesViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/27/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSCitiesViewController.h"
#import <DejalActivityView.h>
#import "CSSearchFoursquareViewController.h"

@interface CSCitiesViewController ()

@end

@implementation CSCitiesViewController {
    
    UITableView *locationsTable;
    NSMutableArray *objects;
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
	locationsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    locationsTable.delegate = self;
    locationsTable.dataSource = self;
    locationsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:locationsTable];    
    
    [self loadDataView];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    
    locationsTable.tableHeaderView = searchBar;
}
-(void)loadDataView {
    
    objects = [[NSMutableArray alloc] init];
    [objects addObject:@"Cuiaba,MT,Brazil"];
    [objects addObject:@"Aracaju,SE,Brazil"];
    [objects addObject:@"Boston,MA,US"];
    [objects addObject:@"New York,NY,US"];
    [objects addObject:@"Rio de Janeiro,RJ,Brazil"];
    [objects addObject:@"Sao Paulo,SP,Brazil"];
    [objects addObject:@"Cuiaba,PR,Brazil"];
    [objects addObject:@"Santa Catarina,SC,Brazil"];
    [objects addObject:@"Maiami,FL,US"];

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
    NSString *place = [objects objectAtIndex:indexPath.row];
    cell.textLabel.text = place;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *place = [objects objectAtIndex:indexPath.row];
    CSSearchFoursquareViewController *goView  = [self.navigationController.viewControllers objectAtIndex:0];
    goView.locationCity = place;
    [goView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
