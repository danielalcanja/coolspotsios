//
//  CSLocationTopCell.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/22/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CSLocation.h"

@interface CSLocationTopCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withLocation:(CSLocation*)location;

@end
