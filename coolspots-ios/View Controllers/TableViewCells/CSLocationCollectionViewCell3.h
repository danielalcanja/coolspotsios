//
//  CSLocationCollectionViewCell3.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 5/6/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPic.h"


@interface CSLocationCollectionViewCell3 : UICollectionViewCell

-(void)initWithPic:(CSPic*)pic;

@property (strong) CSPic *pic;
@property (strong) UIImage *image;

@end
