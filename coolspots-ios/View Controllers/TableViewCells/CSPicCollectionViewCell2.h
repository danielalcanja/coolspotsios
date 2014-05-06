//
//  CSPicCollectionViewCell2.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/1/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLocation.h"
#import "CSPic.h"
#import "EGOImageView.h"

@interface CSPicCollectionViewCell2 : UICollectionViewCell {
    EGOImageView *_imageView;

}

@property (strong) CSPic *picture;
-(void)setMosaicDataWithPic:(CSPic *)pic;

@end
