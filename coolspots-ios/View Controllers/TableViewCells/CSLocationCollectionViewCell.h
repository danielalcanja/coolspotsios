//
//  CSLocationCollectionViewCell.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/28/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CSLocation.h"
#import "CSPic.h"

@interface CSLocationCollectionViewCell : UICollectionViewCell {

    UIImageView *_imageView;
    UILabel *_labelTitlePlace;
    UIView *view;
    UIImageView *imageTarja;

}
@property (strong) CSLocation *location;


-(void)setMosaicData:(CSLocation *)newMosaicData;
-(void)setMosaicDataWithPic:(CSPic *)pic;
@end
