//
//  CSContainerPicViewController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/23/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSContainerPicViewController.h"
#import "CSPicCollectionViewCell.h"
#import "CSPic.h"
#import "BackButton.h"

NSString *const CSPicCollectionViewCellIdentifier = @"picCollectionViewCell";


@interface CSContainerPicViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation CSContainerPicViewController {
    
    UICollectionView *picCollectionView;
    NSInteger currentPage;
    UIButton *buttonClose;

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
    
    currentPage = 0;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(320, 567)];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    picCollectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    [picCollectionView setDataSource:self];
    [picCollectionView setDelegate:self];
    [picCollectionView registerClass:[CSPicCollectionViewCell class] forCellWithReuseIdentifier:CSPicCollectionViewCellIdentifier];
    [picCollectionView setBackgroundColor:[UIColor whiteColor]];
    picCollectionView.scrollEnabled = YES;
    picCollectionView.pagingEnabled= YES;
    
    [self.view addSubview:picCollectionView];
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 70)];
    labelTitle.text = self.location.name;
    [labelTitle setFont:[UIFont fontWithName:@"Museo-700" size:20]];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.numberOfLines = 2;
    
    self.navigationItem.titleView = labelTitle;
    
    UIButton* backButton = [[BackButton alloc] backButtonWith:[UIImage imageNamed:@"button-back"] withTtle:@"" leftCapWidth:20];
    [backButton addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}
-(IBAction)closeView:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(320, 567);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberOfItemsInSection = [self.picObjects count];
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
    CSPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSPicCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.multipleTouchEnabled = NO;
    CSPic *pic = [self.picObjects objectAtIndex:indexPath.row];
    [cell initWithPic:pic];
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    
    if(self.index) {
        
        NSIndexPath *iPath =  [NSIndexPath indexPathForRow:self.index inSection:0] ;
        [picCollectionView scrollToItemAtIndexPath:iPath  atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPage = page;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
