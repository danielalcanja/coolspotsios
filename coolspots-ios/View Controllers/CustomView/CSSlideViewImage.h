//
//  CSSlideViewImage.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/21/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSImageView.h"

@interface CSSlideViewImage : UIView

@property (strong, nonatomic) CSImageView *imageView;
@property (strong, nonatomic) UILabel   *labelCaption;
@property (strong, nonatomic) UIImageView *bgCaption;

-(void)reloadDataWithImageUrl:(NSString*)imageUrl caption:(NSString*)caption;


@end
