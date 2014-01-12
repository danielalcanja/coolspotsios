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

@implementation CSLocationSlideCell {
    
    UIScrollView *scrollView;
    OMPageControl *pageControl;
    UILabel *labelTitlePlace;
    UIButton *buttonMore;
    
    UIViewController *_controller;
    CSLocation *_location;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withViewController:(UIViewController*)controller
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
        
        UIButton *buttonFallow = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonFallow.frame = CGRectMake(239, 325, 30,30);
        buttonFallow.backgroundColor = [UIColor clearColor];
        [buttonFallow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        UIImage *buttonImageNormalFallow = [UIImage imageNamed:@"button-bookmark"];
        UIImage *strechableButtonImageNormalFallow = [buttonImageNormalFallow stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [buttonFallow setBackgroundImage:strechableButtonImageNormalFallow forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"button-bookmark-on"];
        UIImage *strechableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [buttonFallow setBackgroundImage:strechableButtonImagePressed forState:UIControlStateHighlighted];
        
        [self.contentView addSubview:buttonFallow];
        
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
        
        [self.contentView addSubview:scrollView];
        
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
    }
    return self;
}
-(void)reloadCellWithLocation:(CSLocation*)location {
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * 5, scrollView.frame.size.height)];
    labelTitlePlace.text = location.name;
    _location = location;
    
    for(int i=0;i<[location.pics count];i++) {
        
        CSPic *pic = [location.pics objectAtIndex:i] ;
    
        NSString *standard_resolution = pic.standard_resolution;

        
        CSImageView *imageView = [[CSImageView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        
        [imageView setURL:standard_resolution];
        
        [scrollView addSubview:imageView];
        
        UIImage *image1=[UIImage imageNamed:@"tarja-principal-pic"];
        UIImageView *image= [[UIImageView alloc] initWithImage:image1];
        image.frame=CGRectMake(scrollView.frame.size.width * i,270,320,50);
        //image.alpha = 1.0;
        [scrollView  addSubview:image];
        
        UILabel *labelCaption = [[UILabel alloc] initWithFrame:CGRectMake(6 + scrollView.frame.size.width * i,270,300,50)];
        [labelCaption setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        labelCaption.numberOfLines = 3;
        labelCaption.backgroundColor  = [UIColor clearColor];
        labelCaption.textColor  = [UIColor whiteColor];
        labelCaption.text = pic.caption;
        [scrollView addSubview:labelCaption];
    }
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
