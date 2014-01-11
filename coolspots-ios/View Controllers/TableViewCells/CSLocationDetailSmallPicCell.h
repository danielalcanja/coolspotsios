//
//  CSLocationDetailSmallPicCell.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/21/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CSPic.h"

@interface CSLocationDetailSmallPicCell : UITableViewCell

-(void)reloadCellWithLocation:(CSPic*)pic1 andPic2:(CSPic*)pic2 andPic3:(CSPic*)pic3  withViewController:(UIViewController*)viewController;
@end
