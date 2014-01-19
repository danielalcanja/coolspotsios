//
//  CSFavoritesViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/27/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSFavoritesViewController.h"
#import <DejalActivityView.h>
#import "CSLocation.h"
#import "CSLocationSlideCell.h"
#import "CSAPI.h"
#import "CSSharedData.h"
#import <YIFullScreenScroll.h>


@interface CSFavoritesViewController ()

@end

@implementation CSFavoritesViewController {
    
    UITableView *locationsTable;
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
	// Do any additional setup after loading the view.

    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    labelTitle.text = @"Favorites";
    [labelTitle setFont:[UIFont fontWithName:@"Museo-700" size:20]];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;
    self.navigationItem.titleView = labelTitle;
    
    isFirstLoad = YES;
    page = 1;
    
    locationsTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    locationsTable.delegate = self;
    locationsTable.dataSource = self;
    locationsTable.backgroundColor = [UIColor clearColor];
    locationsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:locationsTable];
    
    objects = [[NSMutableArray alloc] init];
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"ADD_REMOVE_FAV" object:nil];
    [self loadData];

}
-(void)loadData{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *username = [prefs stringForKey:@"username"];
    
    
    [[CSAPI sharedInstance] getFavoriteLocationsWithPage:[NSNumber numberWithInt:page] username:username delegate:self];
}
-(void)getFavoriteLocationsSucceeded:(NSMutableArray *)dictionary {
    
    isFirstLoad = NO;
    objects = dictionary;
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
            cell = [[CSLocationSlideCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withViewController:self];
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

@end
