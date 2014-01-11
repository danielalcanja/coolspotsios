//
//  CSLocationLargeCoverCell.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/20/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CSLocation.h"  
#import "CSPic.h"

@interface CSLocationLargeCoverCell : UITableViewCell

@property  (nonatomic,strong) EGOImageView *egoImageView;

-(void)reloadCellWithLocation:(CSLocation*)location;


@end
