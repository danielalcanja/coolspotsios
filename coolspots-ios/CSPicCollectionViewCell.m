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

#define FONT_SIZE 12.0f
#define CELL_CONTENT_WIDTH 240
#define CELL_CONTENT_MARGIN 2.0f

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
        [labelUser setFont:[UIFont fontWithName:@"Museo-700" size:13]];
        labelUser.numberOfLines = 3;
        labelUser.backgroundColor  = [UIColor clearColor];
        labelUser.textColor  = [UIColor whiteColor];
        [scrollView addSubview:labelUser];
        
        
        labelCaption = [[UILabel alloc] initWithFrame:CGRectZero];
        [labelCaption setFont:[UIFont fontWithName:@"Museo-500" size:FONT_SIZE]];
        labelCaption.backgroundColor  = [UIColor clearColor];
        labelCaption.textColor  = [UIColor whiteColor];
        [labelCaption setNumberOfLines:0];
        [labelCaption setLineBreakMode:NSLineBreakByWordWrapping];
        [labelCaption setMinimumScaleFactor:FONT_SIZE];
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
    
    NSString *text = pic.caption;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize expectedSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    [labelCaption setFrame:CGRectMake(75, 390, 240, MAX(expectedSize.height, 43.0f))];


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
