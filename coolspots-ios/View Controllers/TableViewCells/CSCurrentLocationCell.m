//
//  CSCurrentLocationCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/28/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSCurrentLocationCell.h"

@implementation CSCurrentLocationCell {
    UILabel *label;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIImageView *imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-bg-blue"]];
        imageBg.frame = CGRectMake(0, 0, 320, 30);
        
        [self.contentView addSubview:imageBg];
        
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 30)];
        [label setFont:[UIFont fontWithName:@"Museo-500" size:16]];
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:label];
    
    }
    return self;
}
-(void)reloadDataWithCurrentLocation:(NSString *)currentLocation {
    
    label.text = currentLocation;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
