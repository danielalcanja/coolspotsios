//
//  CSPicCollectionViewCell.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/23/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPic.h"
#import "CSImageView.h" 

@interface CSPicCollectionViewCell : UICollectionViewCell

-(void)initWithPic:(CSPic*)pic;
@property (strong, nonatomic) CSImageView *userPic;


@end
