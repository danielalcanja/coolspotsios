//
//  CSLocationSlideCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/21/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocationSlideCell.h"
#import "OMPageControl.h"
#import "CSLocationDetailViewController.h"
#import "CSImageView.h"
#import "CSPic.h"
#import "CSSlideViewImage.h"

@implementation CSLocationSlideCell {
    
    UIScrollView *scrollView;
    OMPageControl *pageControl;
    UILabel *labelTitlePlace;
    UIButton *buttonMore;
    
    UIViewController *_controller;
    CSLocation *_location;
    CSFavButton *buttonFav;
    
    CSSlideViewImage *slideViewImage1;
    CSSlideViewImage *slideViewImage2;
    CSSlideViewImage *slideViewImage3;
    CSSlideViewImage *slideViewImage4;
    CSSlideViewImage *slideViewImage5;
    
    UILabel *labelUsersOnline;


}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withViewController:(UIViewController*)controller location:(Location*)location
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _controller = controller;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       // self.backgroundColor = [UIColor blackColor];
        
        NSString *imgBarCagegory = @"bar-places-museums";
        
        UIImageView *imageBgPlaceTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgBarCagegory]];
        imageBgPlaceTitle.frame = CGRectMake(0, 320, 320,95);
        [self.contentView addSubview:imageBgPlaceTitle];
        
        buttonMore = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonMore.frame = CGRectMake(280, 325, 30,30);
        buttonMore.backgroundColor = [UIColor clearColor];
        [buttonMore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        UIImage *buttonImageNormal = [UIImage imageNamed:@"button-more"];
        UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [buttonMore setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
        [self.contentView addSubview:buttonMore];
        [buttonMore addTarget:self action:@selector(goToDetailViewController:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonFav = [[CSFavButton alloc] initWithFrame:CGRectMake(239, 325, 30,30) isFavorite:NO];
        [self.contentView addSubview:buttonFav];
        
        labelTitlePlace = [[UILabel alloc] init];
        labelTitlePlace.frame = CGRectMake(6, 320, 230, 44);
        [labelTitlePlace setFont:[UIFont fontWithName:@"Museo-500" size:16]];
        labelTitlePlace.backgroundColor = [UIColor clearColor];
        labelTitlePlace.numberOfLines = 2;
        [labelTitlePlace setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:labelTitlePlace];
        
        float pageControlHeight = 18;
        
        CGRect scrollViewRect = [self.contentView bounds];
        scrollViewRect.size.height -= pageControlHeight;
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320,320)];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor clearColor];
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * 5, scrollView.frame.size.height)];
        
        [self.contentView addSubview:scrollView];
        
        UIImageView *imgOnlineUsers = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"num-icon-user"]];
        imgOnlineUsers.frame = CGRectMake(250, 10, 20, 18);
        [self.contentView addSubview:imgOnlineUsers];
        
        labelUsersOnline = [[UILabel alloc] init];
        labelUsersOnline.frame = CGRectMake(277, 11, 40, 20);
        [labelUsersOnline setFont:[UIFont fontWithName:@"Museo-500" size:16]];
        labelUsersOnline.backgroundColor = [UIColor clearColor];
        labelUsersOnline.numberOfLines = 2;
        labelUsersOnline.text = @"23";
        [labelUsersOnline setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:labelUsersOnline];
        
        CGRect pageViewRect = [self.contentView bounds];
        pageViewRect.size.height = pageControlHeight;
        pageViewRect.origin.y = 250;
        
        pageControl = [[OMPageControl alloc] initWithFrame:pageViewRect];
        pageControl.currentPage = 0;
        pageControl.numberOfPages = 5;
        pageControl.imageNormal = [UIImage imageNamed:@"ajuda_dot_off"];
        pageControl.imageCurrent = [UIImage imageNamed:@"ajuda_dot_on"];
        pageControl.backgroundColor = [UIColor clearColor];
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];

        [self.contentView addSubview:pageControl];
        
        slideViewImage1 = [[CSSlideViewImage alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * 0, 0, 320,320)];
        [scrollView addSubview:slideViewImage1];
        slideViewImage2 = [[CSSlideViewImage alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * 1, 0, 320,320)];
        [scrollView addSubview:slideViewImage2];
        slideViewImage3 = [[CSSlideViewImage alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * 2, 0, 320,320)];
        [scrollView addSubview:slideViewImage3];
        
        slideViewImage4 = [[CSSlideViewImage alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * 3, 0, 320,320)];
        [scrollView addSubview:slideViewImage4];
        
        slideViewImage5 = [[CSSlideViewImage alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * 4, 0, 320,320)];
        [scrollView addSubview:slideViewImage5];
        
    }
    return self;
}
-(void)reloadCellWithLocation:(Location*)location {
    
    labelTitlePlace.text = location.name;
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [[appDelegate apiInstagram] getMediaWithID:location.instagramid MAX_ID:nil delegate:self];
    
}
-(void)getMediaSucceeded:(NSDictionary *)response {
    
    NSArray *data = [response objectForKey:@"data"];
    int i=0;
    for(NSDictionary *media in data) {
        
        NSDictionary *images = [media valueForKey:@"images"];
        NSDictionary *caption = [media valueForKey:@"caption"];
        NSDictionary *image = [images valueForKey:@"standard_resolution"];
        NSString *standard_resolution = [image valueForKey:@"url"];
        NSString *text = [caption valueForKey:@"text"];

        //NSLog(@"_________________________________________________________response %@", standard_resolution);

        if(i==0 && [data count]>1) {
            [slideViewImage1 reloadDataWithImageUrl:standard_resolution caption:text];
        }
        if(i==1 && [data count]>2) {
            [slideViewImage2 reloadDataWithImageUrl:standard_resolution caption:text];
        }
        if(i==2 && [data count]>3) {
            [slideViewImage3 reloadDataWithImageUrl:standard_resolution caption:text];
        }
        if(i==3 && [data count]>4) {
            [slideViewImage4 reloadDataWithImageUrl:standard_resolution caption:text];
        }
        if(i==4 && [data count]>5) {
            [slideViewImage5 reloadDataWithImageUrl:standard_resolution caption:text];
        }
        i++;

    }
}
-(void)getMediaError:(NSError *)error {
    NSLog(@"getMediaError %@", error);

}
- (void)scrollViewDidScroll:(UIScrollView *)sView
{
	CGFloat offset = scrollView.contentOffset.x;
	CGFloat pageSize = scrollView.frame.size.width;
	
	int page = floor((offset + (pageSize/2)) / pageSize);
	pageControl.currentPage = page;
}
- (void)changePage:(id)sender
{
	NSInteger page = pageControl.currentPage;
    
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}
-(IBAction)goToDetailViewController:(id)sender {

    CSLocationDetailViewController *goView = [[CSLocationDetailViewController alloc] init];
    goView.location = _location;
    goView.hidesBottomBarWhenPushed = YES;
    goView.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [_controller.navigationController pushViewController:goView animated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
