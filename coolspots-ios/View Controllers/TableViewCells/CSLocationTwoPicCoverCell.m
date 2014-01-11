//
//  CSLocationTwoPicCoverCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/20/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocationTwoPicCoverCell.h"

@implementation CSLocationTwoPicCoverCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.egoImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        self.egoImageView.frame = CGRectMake(0, 0, 155, 155);
        
        [self.contentView addSubview:self.egoImageView];
        
        self.egoSecondImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        self.egoSecondImageView.frame = CGRectMake(160, 0, 155, 155);
        
        [self.contentView addSubview:self.egoSecondImageView];
        
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

-(void)reloadCellWithLocation:(CSLocation*)location {
    
    NSString *standard_resolution = [[location.pics objectAtIndex:0] objectForKey:@"standard_resolution"];
    NSString *secondStandard_resolution = [[location.pics objectAtIndex:1] objectForKey:@"standard_resolution"];

    self.egoImageView.imageURL = [NSURL URLWithString:standard_resolution];
    
    self.egoSecondImageView.imageURL = [NSURL URLWithString:secondStandard_resolution];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
