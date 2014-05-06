//
//  CSLocationsViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/28/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocationsViewController.h"
#import "MosaicLayout.h"
#import "MosaicCell.h"
#import "CSLocation.h"
#import <RestKit.h>
#import "CSLocationCollectionViewCell.h"
#import "CSLocationDetailViewController.h"



#define kDoubleColumnProbability 40



@interface CSLocationsViewController ()

@end

@implementation CSLocationsViewController {
    NSMutableArray *objects;
     int page;

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
    
    objects = [[NSMutableArray alloc] init];
    page = 1;
    MosaicLayout *layout = [[MosaicLayout alloc] init];
    
    CGRect frame = self.view.frame;
    frame.size.height = 520;
    locationCollectionView=[[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [(MosaicLayout *)locationCollectionView.collectionViewLayout setDelegate:self];

    locationCollectionView.delegate = self;
    [locationCollectionView setDataSource:self];
    [self.view addSubview:locationCollectionView];
    
    self.fullScreenScroll = [[YIFullScreenScroll alloc] initWithViewController:self scrollView:locationCollectionView style:YIFullScreenScrollStyleFacebook];
    self.fullScreenScroll.delegate = self;
    self.fullScreenScroll.shouldHideNavigationBarOnScroll = YES;
    self.fullScreenScroll.shouldHideToolbarOnScroll = YES;
    self.fullScreenScroll.shouldHideTabBarOnScroll = NO;
    
    [locationCollectionView registerClass:[CSLocationCollectionViewCell class] forCellWithReuseIdentifier:@"locationCollectionViewCell"];
    
    [self loadData];
}
-(void)loadData {
   
    NSString *city = @"Boston";
    [[CoolSpotsAPI sharedInstance] getLocationsWithCity:city delegate:self];
    
}
-(void)getLocationsSucceeded:(NSArray *)response {
    
    if([objects count] > 0) {
        [objects addObjectsFromArray:[response mutableCopy]];
    }else {
        objects = [response mutableCopy];
    }
    [locationCollectionView reloadData];
    
}
-(void)getLocationsError:(NSError *)error {
    NSLog(@"getLocationsError %@", error);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([objects count] >= 18)
    {
        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
            
            page++;
            [self loadData];
            
        }
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [objects count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"locationCollectionViewCell";
    
    Location *location = [objects objectAtIndex:indexPath.row];
    location.firstTimeShown = YES;


    CSLocationCollectionViewCell *cell = (CSLocationCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.location = location;
    [cell reloadCellWithLocation:location];
    
    float randomWhite = (arc4random() % 40 + 10) / 255.0;
    cell.backgroundColor = [UIColor colorWithWhite:randomWhite alpha:1];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    Location *location = [objects objectAtIndex:indexPath.row];
    
    CSLocationDetailViewController *goView = [[CSLocationDetailViewController alloc] init];
    goView.location = location;
    goView.hidesBottomBarWhenPushed = YES;
    goView.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController pushViewController:goView animated:YES];
    
}
#pragma mark - MosaicLayoutDelegate

-(float)collectionView:(UICollectionView *)collectionView relativeHeightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //  Base relative height for simple layout type. This is 1.0 (height equals to width)
    float retVal = 1.0;
    
    Location *aMosaicModule = [objects objectAtIndex:indexPath.row];
    
    if (aMosaicModule.relativeHeight != 0){
        
        //  If the relative height was set before, return it
        retVal = aMosaicModule.relativeHeight;
        
    }else{
        
        BOOL isDoubleColumn = [self collectionView:collectionView isDoubleColumnAtIndexPath:indexPath];
        if (isDoubleColumn){
            //  Base relative height for double layout type. This is 0.75 (height equals to 75% width)
            retVal = 0.75;
        }
        
        /*  Relative height random modifier. The max height of relative height is 25% more than
         *  the base relative height */
        
        float extraRandomHeight = arc4random() % 25;
        retVal = retVal + (extraRandomHeight / 100);
        
        /*  Persist the relative height on MosaicData so the value will be the same every time
         *  the mosaic layout invalidates */
        
        aMosaicModule.relativeHeight = retVal;
    }
    
    return retVal;
}

-(BOOL)collectionView:(UICollectionView *)collectionView isDoubleColumnAtIndexPath:(NSIndexPath *)indexPath{
    CSLocation *aMosaicModule = [objects objectAtIndex:indexPath.row];
    
    if (aMosaicModule.layoutType == kMosaicLayoutTypeUndefined){
        
        /*  First layout. We have to decide if the MosaicData should be
         *  double column (if possible) or not. */
        
        if ((indexPath.row % 5)==0){
            aMosaicModule.layoutType = kMosaicLayoutTypeDouble;
        }else{
            aMosaicModule.layoutType = kMosaicLayoutTypeSingle;
        }
    }
    
    BOOL retVal = aMosaicModule.layoutType == kMosaicLayoutTypeDouble;
    
    return retVal;
    
}
-(NSUInteger)numberOfColumnsInCollectionView:(UICollectionView *)collectionView{

    return 2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-ios7"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
