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
    
    EGOImageView *egoImageView;
    UILabel *labelCaption;
    UILabel *labelUser;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        egoImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        egoImageView.frame = CGRectMake(0, 0, 320, 320);
        [self.contentView addSubview:egoImageView];
        
        labelUser = [[UILabel alloc] initWithFrame:CGRectMake(7, 470, 306, 40)];
        [labelUser setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        labelUser.numberOfLines = 3;
        labelUser.backgroundColor  = [UIColor clearColor];
        labelUser.textColor  = [UIColor whiteColor];
        [self.contentView addSubview:labelUser];
        
        labelCaption = [[UILabel alloc] initWithFrame:CGRectMake(7, 500, 306, 40)];
        [labelCaption setFont:[UIFont fontWithName:@"Helvetica" size:11]];
        labelCaption.numberOfLines = 3;
        labelCaption.backgroundColor  = [UIColor clearColor];
        labelCaption.textColor  = [UIColor whiteColor];
        [self.contentView addSubview:labelCaption];
        
    }
    return self;
}
-(void)initWithPic:(CSPic*)pic {
    
    egoImageView.imageURL = [NSURL URLWithString:pic.standard_resolution];
    labelCaption.text = pic.caption;
    labelUser.text = @"Daniel Alcanja";

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
