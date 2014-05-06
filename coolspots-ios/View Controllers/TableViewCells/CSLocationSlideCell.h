//
//  CSLocationSlideCell.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/21/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CSLocation.h"
#import "CSFavButton.h"
#import "APIInstagram.h"
#import "AppDelegate.h"

@interface CSLocationSlideCell : UITableViewCell<UIScrollViewDelegate,CSGetMediaCaller>
-(void)reloadCellWithLocation:(Location*)location;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withViewController:(UIViewController*)controller location:(Location*)location;
@end
