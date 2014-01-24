//
//  CSLocationDetailViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/21/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocationDetailViewController.h"
#import <RestKit.h>
#import "CSPic.h"
#import "CSLocationDetailThreeCell.h"
#import "CSLocationDetailSmallPicCell.h"
#import "CSLocationTopCell.h"
#import <DejalActivityView.h>
#import "CSContainerPicViewController.h"
#import "CSLocationSlideCell.h"
#import "BackButton.h"
#import "MosaicCell.h"
#import "MosaicLayout.h"
#import "CSLocationCollectionViewCell.h"
#import "CSPicCollectionViewCell2.h"


#define kDoubleColumnProbability 40

@interface CSLocationDetailViewController ()

@end

@implementation CSLocationDetailViewController {
    
    NSMutableArray *objects;
    CGPoint scroolPointNow;
    UIView *viewPlaceInfo;
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
	// Do any additional setup after loading the view.
    page = 1;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 70)];
    labelTitle.text = self.location.name;
    [labelTitle setFont:[UIFont fontWithName:@"Museo-500" size:20]];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;

    self.navigationItem.titleView = labelTitle;
    
    UILabel *labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 50)];
    labelAddress.text = @"43 O’Farrel St. San Francisco - CA 94102";
    [labelAddress setFont:[UIFont fontWithName:@"Museo-300" size:13]];
    labelAddress.textColor = [UIColor whiteColor];
    labelAddress.numberOfLines = 2;
    
   
    UIButton* backButton = [[BackButton alloc] backButtonWith:[UIImage imageNamed:@"button-back"] withTtle:@"" leftCapWidth:20];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
   
    CGFloat headerSize = 130;
    
    UIImageView *imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-bg-blue"]];
    imageBg.frame = CGRectMake(0, 0, 320, 55);
    
    UIImageView *bgButtons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-bg-blue"]];
    bgButtons.frame = CGRectMake(0, 55.3, 320, 75);
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, headerSize-100, 320, 30)];
    labelName.textAlignment = NSTextAlignmentCenter;
    [labelName setFont:[UIFont fontWithName:@"Museo-500" size:20]];
    labelName.textColor = [UIColor whiteColor];
    labelName.text = self.location.name;
    
    CGFloat spaceBtwButtons = 30;
    CGFloat spaceHight = 65;
    
    CSFavButton *buttonFav = [[CSFavButton alloc] initWithFrame:CGRectMake(15, headerSize-spaceHight, 35,35) isFavorite:NO];
    [buttonFav reloadControlWithIdLocation:[NSString stringWithFormat:@"%d",self.location.id] isFavorite:self.location.isFavorite];
    
    CSFavButton *buttonShare = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonFav.frame.origin.x + buttonFav.frame.size.width + spaceBtwButtons, headerSize-spaceHight, 35,35) isFavorite:NO];
    [buttonShare.button setBackgroundImage:[UIImage imageNamed:@"button-share"] forState:UIControlStateNormal];
    
    CSFavButton *buttonEvent = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonShare.frame.origin.x + buttonShare.frame.size.width + spaceBtwButtons, headerSize-spaceHight, 35,35) isFavorite:NO];
    [buttonEvent.button setBackgroundImage:[UIImage imageNamed:@"button-events"] forState:UIControlStateNormal];

    
    CSFavButton *buttonComments = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonEvent.frame.origin.x + buttonEvent.frame.size.width + spaceBtwButtons, headerSize-spaceHight, 35,35) isFavorite:NO];
    [buttonComments.button setBackgroundImage:[UIImage imageNamed:@"button-comments"] forState:UIControlStateNormal];
    
    CSFavButton *buttonMoreInfo = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonComments.frame.origin.x + buttonComments.frame.size.width + spaceBtwButtons, headerSize-spaceHight, 35,35) isFavorite:NO];
    [buttonMoreInfo.button setBackgroundImage:[UIImage imageNamed:@"button-more"] forState:UIControlStateNormal];

    viewPlaceInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, headerSize)];
    [viewPlaceInfo addSubview:imageBg];
    [viewPlaceInfo addSubview:bgButtons];
    [viewPlaceInfo addSubview:labelAddress];

    [viewPlaceInfo addSubview:buttonFav];
    [viewPlaceInfo addSubview:buttonShare];
    [viewPlaceInfo addSubview:buttonEvent];
    [viewPlaceInfo addSubview:buttonComments];
    [viewPlaceInfo addSubview:buttonMoreInfo];
    
    UILabel *labelTag = [[UILabel alloc] initWithFrame:CGRectMake(10, headerSize-(spaceHight-40), 320, 20)];
    labelTag.text = @"#people       #food       #drink";
    [labelTag setFont:[UIFont fontWithName:@"Museo-500" size:16]];
    labelTag.textColor = [UIColor whiteColor];
    [viewPlaceInfo addSubview:labelTag];

    [self.view addSubview:viewPlaceInfo];
    
    UIView *viewTags = [[UIView alloc] initWithFrame:CGRectMake(0, headerSize, 320, 0)];
    viewTags.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewTags];
    
    page = 1;
    MosaicLayout *layout = [[MosaicLayout alloc] init];
    
    CGRect frameTable = self.view.frame;
    frameTable.origin.y = headerSize+viewTags.frame.size.height;
    
    
    picsCollectionView=[[UICollectionView alloc] initWithFrame:frameTable collectionViewLayout:layout];
    [(MosaicLayout *)picsCollectionView.collectionViewLayout setDelegate:self];
    picsCollectionView.delegate = self;
    picsCollectionView.backgroundColor = [UIColor whiteColor];
    [picsCollectionView setDataSource:self];
    [self.view addSubview:picsCollectionView];
    
    [picsCollectionView registerClass:[CSPicCollectionViewCell2 class] forCellWithReuseIdentifier:@"picCollectionViewCell"];
    
    objects = [[NSMutableArray alloc] init];
    [self loadData];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y<scroolPointNow.y) {
        if(scroolPointNow.y <= 100)
        {
            NSLog(@"down %f", scroolPointNow.y);
            
            [self swipePlaceInfoToDown];
        }
        
        
    } else if (scrollView.contentOffset.y>scroolPointNow.y) {
        NSLog(@"swipeUpNavigationBar");
        
        [self swipePlaceInfoToTop];

    }
    
}
-(void)swipePlaceInfoToDown
{
    
    CGRect frameTable = self.view.frame;
    frameTable.origin.y = 130;
   
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    viewPlaceInfo.frame = CGRectMake(0, 0, 320, 130);
    picsCollectionView.frame = frameTable;

    
    [UIView commitAnimations];


}
-(void)swipePlaceInfoToTop
{
    
    CGRect frameTable = self.view.frame;
    frameTable.origin.y = 130-60;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    viewPlaceInfo.frame = CGRectMake(0, -60, 320, 130);
    picsCollectionView.frame = frameTable;

    
    [UIView commitAnimations];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [objects count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"picCollectionViewCell";
    
    CSPic *pic = [objects objectAtIndex:indexPath.row];
    
    CSPicCollectionViewCell2 *cell = (CSPicCollectionViewCell2 *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.picture = pic;
    [cell setMosaicDataWithPic:pic];
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CSContainerPicViewController *viewController = [[CSContainerPicViewController alloc] init];
    viewController.picObjects = objects;
    viewController.index = indexPath.row;
    viewController.location = self.location;
    viewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar-detail-title-blue"] forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark - MosaicLayoutDelegate

-(float)collectionView:(UICollectionView *)collectionView relativeHeightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //  Base relative height for simple layout type. This is 1.0 (height equals to width)
    float retVal = 1.0;
    
    CSPic *aMosaicModule = [objects objectAtIndex:indexPath.row];
    
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
    
    CSPic *aMosaicModule = [objects objectAtIndex:indexPath.row];
    
    if (aMosaicModule.layoutType == kPicMosaicLayoutTypeUndefined){
        
        /*  First layout. We have to decide if the MosaicData should be
         *  double column (if possible) or not. */
        
        NSUInteger random = arc4random() % 100;
        if (random < kDoubleColumnProbability){
            aMosaicModule.layoutType = kPicMosaicLayoutTypeDouble;
        }else{
            aMosaicModule.layoutType = kPicMosaicLayoutTypeSingle;
        }
    }
    
    BOOL retVal = aMosaicModule.layoutType == kPicMosaicLayoutTypeDouble;
    
    return retVal;
    
}
-(NSUInteger)numberOfColumnsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadData {
    
    [DejalBezelActivityView activityViewForView:picsCollectionView];

    [[CSAPI sharedInstance] getPhotosWithID:[NSNumber numberWithInt:self.location.id] page:[NSNumber numberWithInt:page]  delegate:self];
}
-(void)getPhotosSucceeded:(NSMutableArray *)dictionary {
    
    objects = dictionary;
    [picsCollectionView reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];

    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([objects count] >= 18)
    {
        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
            
            page++;
            
            [[CSAPI sharedInstance] getPhotosWithID:[NSNumber numberWithInt:self.location.id] page:[NSNumber numberWithInt:page]  delegate:self];
            
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 1;
    if(section==1) {
        if (([objects count] % 2) == 0) {
            numberOfRows = [objects count]/3;
        } else {
            numberOfRows = ([objects count]/3) + 1;
        }
    }
    return numberOfRows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0) {
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"locationSlideCell"] ;
        CSLocationTopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[CSLocationTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withLocation:self.location];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        return cell;
        
    }else  {
        
        if((indexPath.row % 2) == 0)
        {
            NSString *CellIdentifier = [NSString stringWithFormat:@"locationDetailThreeCell"] ;
            CSLocationDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[CSLocationDetailThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            CSPic *pic1 = [objects objectAtIndex:indexPath.row];
            CSPic *pic2 = [objects objectAtIndex:indexPath.row];
            CSPic *pic3 = [objects objectAtIndex:indexPath.row];
            
            [cell reloadCellWithLocation:pic1 andPic2:pic2 andPic3:pic3 withViewController:self];
            return cell;
            
            
        }else {
            
            NSString *CellIdentifier = [NSString stringWithFormat:@"locationDetailSmallPicCell"] ;
            CSLocationDetailSmallPicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[CSLocationDetailSmallPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            CSPic *pic1 = [objects objectAtIndex:indexPath.row];
            CSPic *pic2 = [objects objectAtIndex:indexPath.row];
            CSPic *pic3 = [objects objectAtIndex:indexPath.row];
            
            [cell reloadCellWithLocation:pic1 andPic2:pic2 andPic3:pic3 withViewController:self];
            return cell;
        }
        
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 80;
    if(indexPath.row != 0) {
        
        if((indexPath.row % 2) == 0)
        {
            height = 212;
        }else  {
            height = 108;
        }
        
    }
    return height;
}

-(IBAction)didSelectPic:(id)sender {
    
    CSContainerPicViewController *viewController = [[CSContainerPicViewController alloc] init];
    viewController.picObjects = objects;
    viewController.index = 1;
    viewController.location = self.location;
    viewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar-detail-title-blue"] forBarMetrics:UIBarMetricsDefault];

    [self presentViewController:nav animated:YES completion:nil];
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section==1){
        NSString *bgDetail = @"bar-places-museums";
        
        UIImageView *imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgDetail]];
        imageBg.frame = CGRectMake(0, 0, 320, 50);
        
        UIButton *buttonFallow = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonFallow.frame = CGRectMake(15, 8, 35,35);
        buttonFallow.backgroundColor = [UIColor clearColor];
        [buttonFallow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        UIImage *buttonImageNormalFallow = [UIImage imageNamed:@"button-bookmark"];
        UIImage *strechableButtonImageNormalFallow = [buttonImageNormalFallow stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [buttonFallow setBackgroundImage:strechableButtonImageNormalFallow forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"button-bookmark-on"];
        UIImage *strechableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [buttonFallow setBackgroundImage:strechableButtonImagePressed forState:UIControlStateHighlighted];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [view addSubview:imageBg];
        [view addSubview:buttonFallow];

        return view;
    }else{
        
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 0;
    if(section==1) {
        height = 50;
    }
    
    return height;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.navigationController.navigationBar  respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-blue"] forBarMetrics:UIBarMetricsDefault];
    }
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
