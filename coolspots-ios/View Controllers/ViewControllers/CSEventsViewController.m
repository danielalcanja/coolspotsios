//
//  CSEventsViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/27/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSEventsViewController.h"
#import <DejalActivityView.h>
#import "CSLocation.h"
#import "CSLocationSlideCell.h"
#import "CSAPI.h"
#import "CSSharedData.h"
#import <YIFullScreenScroll.h>
#import "CSAddEventViewController.h"

@interface CSEventsViewController ()

@end

@implementation CSEventsViewController{
    
    UITableView *eventsTable;
    NSMutableArray *objects;
    BOOL isFirstLoad;
    int page;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
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
    labelTitle.text = @"Events";
    [labelTitle setFont:[UIFont fontWithName:@"Museo-700" size:20]];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;
    self.navigationItem.titleView = labelTitle;
    
    isFirstLoad = YES;
    page = 1;
    
    eventsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    eventsTable.delegate = self;
    eventsTable.dataSource = self;
    eventsTable.backgroundColor = [UIColor clearColor];
    eventsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:eventsTable];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent:)];
    
    
    objects = [[NSMutableArray alloc] init];
    
    [DejalBezelActivityView activityViewForView:self.view];
    
    if (_refreshHeaderView == nil) {
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - eventsTable.bounds.size.height, self.view.frame.size.width, eventsTable.bounds.size.height)];
        view.delegate = self;
        [eventsTable addSubview:view];
        _refreshHeaderView = view;
        
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
    
    self.fullScreenScroll = [[YIFullScreenScroll alloc] initWithViewController:self scrollView:eventsTable];
    self.fullScreenScroll.shouldShowUIBarsOnScrollUp = NO;
    self.fullScreenScroll.shouldHideNavigationBarOnScroll = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"ADD_REMOVE_FAV" object:nil];
    [self loadData];
    
}
-(IBAction)addEvent:(id)sender {
    
    CSAddEventViewController *addEvent = [[CSAddEventViewController alloc] init];

    UINavigationController *eventNavController = [[UINavigationController alloc] initWithRootViewController:addEvent];
    [eventNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-blue"] forBarMetrics:UIBarMetricsDefault];
    
    eventNavController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:eventNavController animated:YES completion:nil];
    
}
-(void)loadData{
    
    NSString *city = [[CSSharedData sharedInstance] currentCity];

    [[CSAPI sharedInstance] getEventsWithPage:[NSNumber numberWithInt:page] city:city delegate:self];
}
-(void)getEventsSucceeded:(NSMutableArray *)dictionary {
    
    isFirstLoad = NO;
    objects = dictionary;
    [eventsTable reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
    
}
-(void)getEventsError:(NSError *)error {
    
    NSLog(@"getEventsError %@", error);
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
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:eventsTable];
    
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

@end
