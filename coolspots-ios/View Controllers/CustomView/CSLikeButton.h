//
//  CSLikeButton.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/26/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPic.h"
#import "CSAPI.h"

@interface CSLikeButton : UIView<CSAddRemoveLikeDelegate>

@property   (assign) UIButton *button;
@property (assign) BOOL isLiked;
@property  (nonatomic,strong) CSPic *pic;

- (id)initWithFrame:(CGRect)frame isLiked:(BOOL)isLiked;
-(void)reloadControlWithPic:(CSPic*)pic isLiked:(BOOL)isLiked;



@end
