//
//  CSLocationCollectionViewCell.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/28/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "Location.h"
#import "CSPic.h"
#import "AppDelegate.h"
#import "CSModel.h"

@interface CSLocationCollectionViewCell : UICollectionViewCell<CSGetMediaCaller> {

    UILabel *_labelTitlePlace;
    UIView *view;
    UIImageView *imageTarja;
    NSInteger indexImage;

}
@property (strong) EGOImageView *imageCover;

@property (strong) Location *location;
@property (strong) NSString *standard_resolution;

-(void)setMosaicData:(Location *)newMosaicData;
-(void)reloadCellWithLocation:(Location*)location ;
@end
