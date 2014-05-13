//
//  CSLocationDetailViewController2.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 5/6/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSLocationDetailViewController2.h"
#import "BackButton.h"
#import "CSContainerPicViewController.h"
#import "CSImageView.h"
#import "DetailCollectionViewFlowLayout.h"

NSString *const CSPicCollectionViewCellIdentifier2 = @"picCollectionViewCell";
NSString *const infoLocationCollectionViewCell = @"infoLocationCollectionViewCell";



@implementation CSLocationDetailViewController2 {
    
    UICollectionView *picCollectionView;
    NSInteger currentPage;
    BOOL isFistLoad;
    CGFloat _lastContentOffset;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentPage = 0;
    isFistLoad = YES;
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    labelTitle.text = @"Location";
    [labelTitle setFont:[UIFont fontWithName:@"Museo-700" size:20]];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;
    self.navigationItem.titleView = labelTitle;
    
    UIButton* backButton = [[BackButton alloc] backButtonWith:[UIImage imageNamed:@"button-back"] withTtle:@"" leftCapWidth:20];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    DetailCollectionViewFlowLayout *flowLayout = [[DetailCollectionViewFlowLayout alloc] init];

    CGRect frame = self.view.frame;
    picCollectionView=[[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    [picCollectionView setDataSource:self];
    [picCollectionView setDelegate:self];
    [picCollectionView registerClass:[CSLocationCollectionViewCell3 class] forCellWithReuseIdentifier:CSPicCollectionViewCellIdentifier2];
    [picCollectionView registerClass:[CSInfoLocationCollectionViewCell class] forCellWithReuseIdentifier:infoLocationCollectionViewCell];
    picCollectionView.backgroundColor = [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1.0];
    picCollectionView.scrollEnabled = YES;
    picCollectionView.pagingEnabled= YES;
    
    [self.view addSubview:picCollectionView];
    
    self.picObjects = [[NSMutableArray alloc] init];

    [self loadData];
    
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadData {
    
    [DejalBezelActivityView activityViewForView:picCollectionView];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [[appDelegate apiInstagram] getMediaWithID:self.location.instagramid MAX_ID:nil delegate:self];
    
}
-(void)getMediaSucceeded:(NSDictionary *)response {
    
    NSArray *data = [response objectForKey:@"data"];
    
    for(NSDictionary *media in data) {
        
        NSDictionary *images = [media valueForKey:@"images"];
        //NSDictionary *caption = [media valueForKey:@"caption"];
        NSDictionary *image = [images valueForKey:@"standard_resolution"];
        NSString *standard_resolution = [image valueForKey:@"url"];
        
        NSDictionary *caption = [media valueForKey:@"caption"];

        NSString *text = [caption valueForKey:@"text"];
        
        NSDictionary *user = [media valueForKey:@"user"];

        
        CSPic *pic = [[CSPic alloc] init];
        pic.standardResolution = standard_resolution;
        pic.caption = text;
        pic.userFullname = [user valueForKey:@"full_name"];
        pic.profilePicture = [user valueForKey:@"profile_picture"];
        
        [self.picObjects addObject:pic];
    }
    NSArray *pagination = [response objectForKey:@"pagination"];
    self.maxID = [pagination valueForKey:@"next_max_id"];
    if(isFistLoad) {
        
        [picCollectionView reloadData];
        [DejalBezelActivityView removeViewAnimated:YES];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [[appDelegate apiInstagram] getMediaWithID:self.location.instagramid MAX_ID:self.maxID delegate:self];
        isFistLoad = NO;
        
    }
    
}
-(void)getMediaError:(NSError *)error {
    NSLog(@"getMediaError %@", error);
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberOfItemsInSection = [self.picObjects count];
    if(section==3) {
        numberOfItemsInSection = 1;
    }
    return numberOfItemsInSection;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(    NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [picCollectionView reloadData];
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==3) {
        
        CSInfoLocationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:infoLocationCollectionViewCell forIndexPath:indexPath];
        
        [cell initWithLocation:self.location];
        
        return cell;
    }else {
        
        CSLocationCollectionViewCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSPicCollectionViewCellIdentifier2 forIndexPath:indexPath];
        cell.multipleTouchEnabled = NO;
        CSPic *pic = [self.picObjects objectAtIndex:indexPath.row];
        [cell initWithPic:pic];
        float randomWhite = (arc4random() % 40 + 10) / 255.0;
        cell.backgroundColor = [UIColor colorWithWhite:randomWhite alpha:1];
        
        return cell;
    }
    
    
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CSContainerPicViewController *viewController = [[CSContainerPicViewController alloc] init];
    viewController.picObjects = self.picObjects;
    viewController.index = indexPath.row;
    viewController.location = self.location;
    viewController.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-blue"] forBarMetrics:UIBarMetricsDefault];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.navigationController.navigationBar  respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-blue"] forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == (scrollView.contentSize.width - scrollView.frame.size.width)) {

        [picCollectionView reloadData];
        [DejalBezelActivityView removeViewAnimated:YES];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [[appDelegate apiInstagram] getMediaWithID:self.location.instagramid MAX_ID:self.maxID delegate:self];
        
        
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset.x;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    //NSLog(@"------ %ld, %f",(long)scrollView.contentSize.width, scrollView.contentOffset.x);
    
}
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    return CGPointMake(proposedContentOffset.x-100, proposedContentOffset.y);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    float fractionalPage = scrollView.contentOffset.x / 320;
    NSInteger page1 = lround(fractionalPage);
    /*
    float fractionalPage = scrollView.contentOffset.x / 320;
    NSInteger page1 = lround(fractionalPage);

    //frame.origin.x = (257/2)*page1;
    
    [scrollView setContentSize:CGSizeMake(frame.size.width, 257)];
    
    */
    CGRect frame = scrollView.frame;

    NSLog(@"scrollView.contentOffset.x: %f scrollView.width:%f", scrollView.contentOffset.x, frame.size.width);
    //[picCollectionView setContentOffset:CGPointMake(247*page1, scrollView.contentOffset.y)];
    NSLog(@"scrollView.contentOffset.x: %f scrollView.width:%f", scrollView.contentOffset.x, frame.size.width);

    //[picCollectionView scrollRectToVisible:frame animated:YES];


    /*

        NSLog(@"Page %ld",(long)page1);
    
    CGRect frame = scrollView.frame;
    frame.origin.x = (257/2)*page1;

    [picCollectionView scrollRectToVisible:frame animated:YES];
    
    NSInteger page = currentPage;
    
    if (_lastContentOffset < (int)scrollView.contentOffset.x) {
        // moved right
        page = currentPage + 1;
        if([self.picObjects count] > page) {
            [picCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            currentPage = currentPage + 2;
        }
    }
    else if (_lastContentOffset > (int)scrollView.contentOffset.x) {
        page = currentPage - 1;
        if([self.picObjects count] > page) {
            
            [picCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            currentPage = currentPage - 2;
        }
    }
    
    NSLog(@"indexPath.row %ld",page);
    
    float fractionalPage = scrollView.contentOffset.x / 320;
    NSInteger page1 = lround(fractionalPage);
    NSLog(@"%ld",(long)page1);
    */

}

@end
