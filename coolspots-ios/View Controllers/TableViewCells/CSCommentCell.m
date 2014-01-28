//
//  CSCommentCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/26/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSCommentCell.h"
#import "CSImageView.h"


#define FONT_SIZE 12.0f
#define CELL_CONTENT_WIDTH 240
#define CELL_CONTENT_MARGIN 2.0f

@implementation CSCommentCell {
    
    UILabel *labelCaption;
    UILabel *labelUser;
    CSImageView *userPic;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat  y = 10;
        
        userPic = [[CSImageView alloc] initWithFrame:CGRectMake(15, y, 50, 50)];
        [self.contentView addSubview:userPic];
        
        labelUser = [[UILabel alloc] initWithFrame:CGRectMake(75, y, 240, 20)];
        [labelUser setFont:[UIFont fontWithName:@"Museo-700" size:13]];
        labelUser.numberOfLines = 3;
        labelUser.backgroundColor  = [UIColor clearColor];
        labelUser.textColor  = [UIColor whiteColor];
        [self.contentView addSubview:labelUser];
        
        labelCaption = [[UILabel alloc] initWithFrame:CGRectZero];
        [labelCaption setFont:[UIFont fontWithName:@"Museo-500" size:FONT_SIZE]];
        labelCaption.backgroundColor  = [UIColor clearColor];
        labelCaption.textColor  = [UIColor whiteColor];
        [labelCaption setNumberOfLines:0];
        [labelCaption setLineBreakMode:NSLineBreakByWordWrapping];
        [labelCaption setMinimumScaleFactor:FONT_SIZE];
        [self.contentView addSubview:labelCaption];
    
    }
    return self;
}
-(void)reloadDataWith:(CSComment*)comment {
    
    labelCaption.text = comment.text;
    labelUser.text  = comment.username;
    [userPic setURL:comment.profilePicture];

    NSString *text = comment.text;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize expectedSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    [labelCaption setFrame:CGRectMake(75, 5, 240, MAX(expectedSize.height, 43.0f))];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
