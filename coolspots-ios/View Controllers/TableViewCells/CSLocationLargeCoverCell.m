//
//  CSLocationLargeCoverCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/20/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocationLargeCoverCell.h"


@implementation CSLocationLargeCoverCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];

        
        self.egoImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder-image"] ];
        self.egoImageView.frame = CGRectMake(0, 0, 320, 320);
        
        [self.contentView addSubview:self.egoImageView];
        
        
    }
    return self;
}
-(void)reloadCellWithLocation:(CSLocation*)location {
    
    NSString *standard_resolution = [[location.pics objectAtIndex:0] objectForKey:@"standard_resolution"];
    self.egoImageView.imageURL = [NSURL URLWithString:standard_resolution];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
