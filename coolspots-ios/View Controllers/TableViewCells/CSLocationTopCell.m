//
//  CSLocationTopCell.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/22/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocationTopCell.h"

@implementation CSLocationTopCell {
    
    UILabel *labelCategory;
    UILabel *labelAddress;
    UILabel *labelCity;
    UILabel *labelPhone;
    UILabel *labelPhoneText;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withLocation:(Location*)location
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        NSString *bgDetail = @"bg-place-detail-blue";

        UIImageView *imageBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgDetail]];
        imageBg.frame = CGRectMake(0, 0, 320, 129);
        [self.contentView addSubview:imageBg];
        
        labelCategory = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 306, 20)];
        [labelCategory setFont:[UIFont fontWithName:@"Museo-700" size:16]];
        labelCategory.backgroundColor = [UIColor clearColor];
        [labelCategory setTextColor:[UIColor whiteColor]];
        labelCategory.text = @"Pub";
        [self.contentView addSubview:labelCategory];
        
        labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(8,35, 306, 20)];
        [labelAddress setFont:[UIFont fontWithName:@"Museo" size:13]];
        labelAddress.backgroundColor = [UIColor clearColor];
        [labelAddress setTextColor:[UIColor whiteColor]];
        labelAddress.text = @"42 Linden st";
        [self.contentView addSubview:labelAddress];
        
        labelCity = [[UILabel alloc] initWithFrame:CGRectMake(8,55, 306, 20)];
        [labelCity setFont:[UIFont fontWithName:@"Museo" size:13]];
        labelCity.backgroundColor = [UIColor clearColor];
        [labelCity setTextColor:[UIColor whiteColor]];
        labelCity.text = @"Boston";
        [self.contentView addSubview:labelCity];
        
        labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(180, 8, 306, 20)];
        [labelPhone setFont:[UIFont fontWithName:@"Museo-700" size:16]];
        labelPhone.backgroundColor = [UIColor clearColor];
        [labelPhone setTextColor:[UIColor whiteColor]];
        labelPhone.text = @"Phone";
        [self.contentView addSubview:labelPhone];
        
        labelPhoneText = [[UILabel alloc] initWithFrame:CGRectMake(180,35, 306, 20)];
        [labelPhoneText setFont:[UIFont fontWithName:@"Museo" size:13]];
        labelPhoneText.backgroundColor = [UIColor clearColor];
        [labelPhoneText setTextColor:[UIColor whiteColor]];
        labelPhoneText.text = @"(657)777-9876";
        [self.contentView addSubview:labelPhoneText];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
-(void)reloadCellWithLocation:(Location*)location {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
