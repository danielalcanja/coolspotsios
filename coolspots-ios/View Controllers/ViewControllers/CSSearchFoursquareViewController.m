//
//  CSSearchFoursquareViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/21/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSSearchFoursquareViewController.h"
#import "CSSharedData.h"
#import "FSLocation.h"


@interface CSSearchFoursquareViewController ()

@end

@implementation CSSearchFoursquareViewController {
    
    UITableView *locationsTable;
    NSMutableArray *objects;
    int nextI;
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
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    labelTitle.text = @"Locations";
    [labelTitle setFont:[UIFont fontWithName:@"Museo-700" size:20]];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;
    self.navigationItem.titleView = labelTitle;
    
    locationsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    locationsTable.delegate = self;
    locationsTable.dataSource = self;
    locationsTable.backgroundColor = [UIColor clearColor];
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
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
}
-(IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)loadDataView {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    
    
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
#if TARGET_IPHONE_SIMULATOR
    latitude = @"40.7";
    longitude = @"-74";
#endif

    
    [[CSAPI sharedInstance] getFoursquareVenusNearWithLatitude:latitude longitude:longitude delegate:self];
    
    
}
-(void)getFSVenusNearSucceeded:(NSDictionary *)dictionary {
    
    objects = [dictionary mutableCopy];
    [locationsTable reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
    
}

-(void)getFSVenusNearError:(NSError *)error {
    
    NSLog(@"getFSVenusNearError %@", error);
}

-(void)getInstagramIDLocationSucceeded:(NSMutableArray *)dictionary {
    
    FSLocation *location = [objects objectAtIndex:nextI];
    
    if([dictionary count] > 0) {
        
        NSMutableDictionary *dicLocation = [[NSMutableDictionary alloc]init];
        [dicLocation setValue:[dictionary valueForKey:@"id"][0] forKey:@"id_instagram"];
        [dicLocation setValue:location.id_foursquare forKey:@"id_foursquare"];
        [dicLocation setValue:location.geo forKey:@"geo"];
        [dicLocation setValue:location.category forKey:@"category"];
        [dicLocation setValue:location.name forKey:@"name"];
        [dicLocation setValue:location.postal_code forKey:@"postal_code:"];
        
        [[CSAPI sharedInstance] addLocationWithDictionary:dicLocation delegate:self];
        
        
    }
    else {
        
        nextI = 0;
        [DejalBezelActivityView removeViewAnimated:YES];
        
    }
    
}
-(void)getAddLocationSucceeded:(NSMutableArray *)dictionary {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"The location has been added."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    
    [DejalBezelActivityView removeViewAnimated:YES];

    
}
-(void)getAddLocationError:(NSError *)error {
    
    NSLog(@"getAddLocationError %@", error);
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
    FSLocation *location = [objects objectAtIndex:indexPath.row];
    cell.textLabel.text = location.name;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [DejalBezelActivityView activityViewForView:self.view];

    nextI = (int)indexPath.row;
    FSLocation *location = [objects objectAtIndex:indexPath.row];
    [[CSAPI sharedInstance] getInstagramIDLocationWithFoursquareID:location.id_foursquare delegate:self];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
