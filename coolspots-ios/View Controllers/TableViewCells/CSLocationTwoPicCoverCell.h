//
//  CSLocationTwoPicCoverCell.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/20/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CSLocation.h"

@interface CSLocationTwoPicCoverCell : UITableViewCell

@property  (nonatomic,strong) EGOImageView *egoImageView;
@property  (nonatomic,strong) EGOImageView *egoSecondImageView;


-(void)reloadCellWithLocation:(CSLocation*)location;


@end
