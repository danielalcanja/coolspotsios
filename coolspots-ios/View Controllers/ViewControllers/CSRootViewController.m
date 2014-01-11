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
#import "CSShareData.h"


@interface CSRootViewController ()

@end

@implementation CSRootViewController {
    
    UITableView *locationsTable;
    NSMutableArray *objects;
    int selectedTypeCell;
    int page;
    
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
	
    page = 1;
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    locationsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    locationsTable.delegate = self;
    locationsTable.dataSource = self;
    locationsTable.backgroundColor = [UIColor clearColor];
    locationsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:locationsTable];
    
    objects = [[NSMutableArray alloc] init];
    
    [self loadDataView];
   
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
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
}

#pragma mark CLLocationManager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    NSLog(@"hereeeee");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    NSLog(@"Detected Location : %f, %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
                       NSLog(@"City %@",placemark.locality);
                       
                       [[CSShareData sharedInstance] setPlacemark:placemark];
                       
                   }];
}

-(void)loadDataView {
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.coolspots.com.br"]];
    
    [client setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    /*
    if([city length]>0) {
        [parameters setObject:city forKey:@"city"];
    }
    */
    [client postPath:@"/json/location" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        
        NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"data"] mutableCopy];
        
        for(int i=0;i<[tempObjects count];i++) {
            
            CSLocation *location = [[CSLocation alloc] init];
            location.id = [[tempObjects valueForKey:@"id"][i] intValue];
            location.name =[tempObjects valueForKey:@"name"][i];
            
            NSMutableArray *pics = [tempObjects valueForKey:@"lastPhotos"][i];
            for(int i=0;i<[pics count];i++) {
                
                CSPic *pic = [[CSPic alloc] init];
                pic.standard_resolution = [pics valueForKey:@"standard_resolution"][i];
                pic.thumbnail = [pics valueForKey:@"thumbnail"][i];
                pic.low_resolution = [pics valueForKey:@"low_resolution"][i];
                location.pics  = [[NSMutableArray alloc] init];
                [location.pics addObject:pic];
            }
            
            [objects addObject:location];
            
        }
        
        [locationsTable reloadData];
        [DejalBezelActivityView removeViewAnimated:YES];


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);

    }];

}

-(void)loadData {
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CSLocation class]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id":   @"id",
                                                  @"name":     @"name",
                                                  @"slug":        @"slug",
                                                  @"lastPhotos": @"pics"
                                                  }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodPOST pathPattern:nil keyPath:nil statusCodes:nil];
    
    //NSString *urlstring = [NSString stringWithFormat:@"http://coolspot/web/json/location?page=%d", page];
    NSString *urlstring = [NSString stringWithFormat:@"http://api.coolspots.com.br"];

    NSURL *url = [NSURL URLWithString:urlstring];
    
    RKObjectMapping* articleRequestMapping = [RKObjectMapping requestMapping ];
    [articleRequestMapping addAttributeMappingsFromDictionary:@{
                                                                @"id":   @"id",
                                                                @"name":     @"name",
                                                                @"slug":        @"slug",
                                                                @"lastPhotos": @"pics"
                                                                }];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:url];
    [manager addResponseDescriptor:responseDescriptor];
    
    NSDictionary *params = @{ @"" : @"{'page':1}"};
    
    [manager.HTTPClient setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    [manager.HTTPClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [manager postObject:params path:@"/json/location" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {

        NSLog(@"We object mapped the response with the following result: %@", result);
        /*
        CSLocation *location = [result firstObject];
        NSMutableArray *pics = location.pics;
        CSPic *pic = [[CSPic alloc] init];
        pic.standard_resolution = [pics objectAtIndex:0];
        NSLog(@"The public timeline Tweets: %@ - %@", location.name, pic.standard_resolution);
        */
        NSMutableArray *tempObjects = [[result array] mutableCopy];
        
        for(int i=0;i<[tempObjects count];i++) {
            
            CSLocation *location = [tempObjects objectAtIndex:i];
            [objects addObject:location];
            
        }
        [locationsTable reloadData];
        [DejalBezelActivityView removeViewAnimated:YES];
        
    } failure:nil];
   
    
}
-(void)getResult {
    
    
    
}
- (void)fetchList
{
    
    CUJSONMapper *objectMapping = [[CUJSONMapper alloc] init];
    [objectMapping registerClass:[CSLocation class] andMappingDescription:@{
                                                                            @"id":   @"id",
                                                                            @"name":     @"name",
                                                                            @"slug":        @"slug",
                                                                            @"lastPhotos": @"pics"
                                                                            }];
    
    CUObjectManager *manager = [[CUObjectManager alloc] init];
    
    manager.baseURLString = @"http://api.coolspots.com.br";
    
    [manager registerMapper:objectMapping
               atServerPath:@"/json/location"
                andJSONPath:@"location"];
    
    ASIHTTPRequest *request =
    [manager postObjectRequestAtPath:@"/json/location" parameters:@{@"page" : @"1" }
                             success:^(ASIHTTPRequest *ASIRequest, NSArray *objects) {
                                 NSLog(@"%@", objects);
                                 
                                 CSLocation *location = [objects firstObject];
                                 NSMutableArray *pics = location.pics;
                                 CSPic *pic = [[CSPic alloc] init];
                                 pic.standard_resolution = [pics objectAtIndex:0];
                                 NSLog(@"The public timeline Tweets: %@ - %@", location.name, pic.standard_resolution);
                                 
                             } error:^(ASIHTTPRequest *ASIRequest, NSString *errorMsg) {
                                 NSLog(@"errrr %@", errorMsg);
                             }];
    
    [request startSynchronous];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];

    if([objects count] >= 18)
    {
        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
            
            page++;
            
            [self loadData];
            
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
    return [objects count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSLocation *location = [objects objectAtIndex:indexPath.row];
    
    /*
    selectedTypeCell = [CSUtil getRandomNumberBetween:0 to:1];
    if(selectedTypeCell ==0) {
    
        NSString *CellIdentifier = [NSString stringWithFormat:@"locationLargeCoverCell"] ;
        CSLocationLargeCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CSLocationLargeCoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell reloadCellWithLocation:location];
        return cell;
        
    }
    if(selectedTypeCell ==1) {
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"locationTwoPicCoverCell"] ;
        CSLocationTwoPicCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CSLocationTwoPicCoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell reloadCellWithLocation:location];
        return cell;
    }
*/
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"locationSlideCell"] ;
    CSLocationSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CSLocationSlideCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withViewController:self];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell reloadCellWithLocation:location];
    return cell;
        
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