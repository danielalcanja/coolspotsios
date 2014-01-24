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
        
        egoImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        egoImageView.frame = CGRectMake(0, 0, 320, 320);
        [scrollView addSubview:egoImageView];
        
        UIImageView *imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-bg-blue"]];
        imageBg.frame = CGRectMake(0, 320, 320, 60);
        [scrollView addSubview:imageBg];
        
        labelUser = [[UILabel alloc] initWithFrame:CGRectMake(7, 320, 306, 40)];
        [labelUser setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        labelUser.numberOfLines = 3;
        labelUser.backgroundColor  = [UIColor clearColor];
        labelUser.textColor  = [UIColor whiteColor];
        [scrollView addSubview:labelUser];
        
        UIImageView *imageBgCaption = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-place-detail-blue"]];
        imageBgCaption.frame = CGRectMake(0, 380, 320, 200);
        [scrollView addSubview:imageBgCaption];
        
        labelCaption = [[UILabel alloc] initWithFrame:CGRectMake(7, 385, 306, 40)];
        [labelCaption setFont:[UIFont fontWithName:@"Helvetica" size:11]];
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
    labelUser.text = @"Daniel Alcanja";
    scrollView.contentSize = CGSizeMake(320,500);


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
