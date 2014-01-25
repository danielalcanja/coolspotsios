//
//  CSPicCollectionViewCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/23/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSPicCollectionViewCell.h"
#import "CSPic.h"
#import "EGOImageView.h"
#import "CSFavButton.h"

@implementation CSPicCollectionViewCell {
    
    UIScrollView *scrollView;
    EGOImageView *egoImageView;
    UILabel *labelCaption;
    UILabel *labelUser;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsVerticalScrollIndicator=YES;
        scrollView.scrollEnabled=YES;
        scrollView.userInteractionEnabled=YES;
        scrollView.alwaysBounceHorizontal = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-bg-blue"]];
        imageBg.frame = self.bounds;
        [scrollView addSubview:imageBg];
        
        egoImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        egoImageView.frame = CGRectMake(0, 0, 320, 320);
        [scrollView addSubview:egoImageView];
        
        CGFloat  y = 330;
        CGFloat  spaceBtwButtons = 20;
    
        CSFavButton *buttonFav = [[CSFavButton alloc] initWithFrame:CGRectMake(15, y, 35,35) isFavorite:NO];
        [scrollView addSubview:buttonFav];

        CSFavButton *buttonShare = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonFav.frame.origin.x + buttonFav.frame.size.width + spaceBtwButtons, y, 35,35) isFavorite:NO];
        [buttonShare.button setBackgroundImage:[UIImage imageNamed:@"button-share"] forState:UIControlStateNormal];
        [scrollView addSubview:buttonShare];
        
        CSFavButton *buttonComments = [[CSFavButton alloc] initWithFrame:CGRectMake(buttonShare.frame.origin.x + buttonShare.frame.size.width + spaceBtwButtons, y, 35,35) isFavorite:NO];
        [buttonComments.button setBackgroundImage:[UIImage imageNamed:@"button-comments"] forState:UIControlStateNormal];
       
        [scrollView addSubview:buttonComments];

        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, y+45, 320, 0.4)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:lineView];
        
        self.userPic = [[CSImageView alloc] initWithFrame:CGRectMake(15, y+50, 50, 50)];
        [scrollView addSubview:self.userPic];
        
    
        labelUser = [[UILabel alloc] initWithFrame:CGRectMake(75, y+45, 240, 20)];
        [labelUser setFont:[UIFont fontWithName:@"Museo-700" size:12]];
        labelUser.numberOfLines = 3;
        labelUser.backgroundColor  = [UIColor clearColor];
        labelUser.textColor  = [UIColor whiteColor];
        [scrollView addSubview:labelUser];
        
        
        labelCaption = [[UILabel alloc] initWithFrame:CGRectMake(75, y+70, 240, 40)];
        [labelCaption setFont:[UIFont fontWithName:@"Museo-500" size:11]];
        labelCaption.numberOfLines = 3;
        labelCaption.backgroundColor  = [UIColor clearColor];
        labelCaption.textColor  = [UIColor whiteColor];
        [scrollView addSubview:labelCaption];
        
        [self.contentView addSubview:scrollView];
        
    }
    return self;
}
-(void)initWithPic:(CSPic*)pic {
    
    egoImageView.imageURL = [NSURL URLWithString:pic.standard_resolution];
    labelCaption.text = pic.caption;
    labelUser.text = pic.username;
    scrollView.contentSize = CGSizeMake(320,500);
    [self.userPic setURL:pic.profilePicture];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
