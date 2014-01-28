//
//  CSRootViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/19/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSRootViewController.h"
#import "CSLocationLargeCoverCell.h"
#import "CSLocationTwoPicCoverCell.h"
#import "CSLocationSlideCell.h"
#import "CSLocation.h"
#import "CSPic.h"
#import <RestKit.h>
#import "GTScrollNavigationBar.h"
#import <CURestkit.h>
#import "CSSharedData.h"
#import "CSSearchFoursquareViewController.h"


@interface CSRootViewController ()

@end

@implementation CSRootViewController {
    
    UITableView *locationsTable;
    NSMutableArray *objects;
    int selectedTypeCell;
    int page;
    
    BOOL isFirstLoad;
    BOOL isAlreadyExecuted;

    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;

}

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

    isFirstLoad = YES;
    isAlreadyExecuted = NO;
    page = 1;
    
   
    locationsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    locationsTable.delegate = self;
    locationsTable.dataSource = self;
    locationsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:locationsTable];
    
    objects = [[NSMutableArray alloc] init];
    
   
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addLocation:)];
    
    [DejalBezelActivityView activityViewForView:self.view];
    
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - locationsTable.bounds.size.height, self.view.frame.size.width, locationsTable.bounds.size.height)];
        view.delegate = self;
        [locationsTable addSubview:view];
        _refreshHeaderView = view;
        
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
        
    self.fullScreenScroll = [[YIFullScreenScroll alloc] initWithViewController:self scrollView:locationsTable];
    self.fullScreenScroll.shouldShowUIBarsOnScrollUp = NO;
    self.fullScreenScroll.shouldHideNavigationBarOnScroll = NO;
    [self startStandardUpdates];
    
    newCityViewController = [[NewCityViewController alloc] init];
    newCityViewController.view.frame = locationsTable.bounds;
    newCityViewController.view.hidden = YES;
    newCityViewController.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newCityViewController.view];

}
-(IBAction)addLocation:(id)sender {
    
    CSSearchFoursquareViewController *goView = [[CSSearchFoursquareViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:goView];
    [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-blue"] forBarMetrics:UIBarMetricsDefault];
    
    navController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navController animated:YES completion:nil];
    
}
- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];
    
    #if TARGET_IPHONE_SIMULATOR
        [[CSSharedData sharedInstance] setCurrentCity:@"Boston"];
        [[CSSharedData sharedInstance] setCurrentCountry:@"United States"];
        [[CSSharedData sharedInstance] setCurrentState:@"MA"];
        [self loadDataView];
    #endif

}
- (void)startSignificantChangeUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    [locationManager startMonitoringSignificantLocationChanges];
}

#pragma mark CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    currentLocation = [locations objectAtIndex:0];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       [[CSSharedData sharedInstance] setCurrentCity:placemark.locality];
                       [[CSSharedData sharedInstance] setCurrentState:placemark.administrativeArea];
                       [[CSSharedData sharedInstance] setCurrentCountryCode:placemark.ISOcountryCode];
                       [[CSSharedData sharedInstance] setCurrentCountry:placemark.country];
                       
                       NSString *city = [[CSSharedData sharedInstance] currentCity];
                       if([city length] > 0) {
                           
                           [self loadDataView];

                       }

                   }];
}


-(void)loadDataView {
    
    if(!isAlreadyExecuted) {
        
        isAlreadyExecuted = YES;
        NSString *city = [[CSSharedData sharedInstance] currentCity];
        NSString *country = [[CSSharedData sharedInstance] currentCountry];
        NSString *state = [[CSSharedData sharedInstance] currentState];

            [[CSAPI sharedInstance] getBestLocationsWithPage:[NSNumber numberWithInt:page] city:[NSString stringWithFormat:@"%@",city] category:nil countryName:country stateName:state  delegate:self];
    
    }
}

-(void)getBestLocationsSucceeded:(NSMutableArray *)dictionary {
    
    isFirstLoad = NO;
    objects = dictionary;
    [[CSSharedData sharedInstance] setNearLocations:objects];
    [locationsTable reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];

    if([objects count] >= 18)
    {
        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
            
            page++;
            
            NSString *city = [[CSSharedData sharedInstance] currentCity];
            NSString *country = [[CSSharedData sharedInstance] currentCountry];
            NSString *state = [[CSSharedData sharedInstance] currentState];
            
            [[CSAPI sharedInstance] getBestLocationsWithPage:[NSNumber numberWithInt:page] city:[NSString stringWithFormat:@"%@",city] category:nil countryName:country stateName:state  delegate:self];
            
        }
    }
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
    if (numberOfRows == 0 && !isFirstLoad)
    {
        numberOfRows = 1;
    }
    
    return numberOfRows;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([objects count] ==0 && !isFirstLoad) {
        
        static NSString *CellIdentifier = @"cellEmptyView";
        
        UITableViewCell *cellEmptyView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cellEmptyView == nil) {
            cellEmptyView = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        newCityViewController.view.hidden = NO;
        
        return cellEmptyView;
        
    }else {
        
        CSLocation *location = [objects objectAtIndex:indexPath.row];
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"locationSlideCell"] ;
        CSLocationSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CSLocationSlideCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withViewController:self location:location];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell reloadCellWithLocation:location];
        return cell;
        
    }
    
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 364;
    
    return height;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:locationsTable];
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.navigationController.navigationBar  respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-ios7"] forBarMetrics:UIBarMetricsDefault];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}



@end
