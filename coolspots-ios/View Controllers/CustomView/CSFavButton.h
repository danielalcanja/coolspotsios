//
//  CSFavButton.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/19/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSFavButton : UIView

@property   (assign) UIButton *button;
@property (assign) BOOL isFavorite;
- (id)initWithFrame:(CGRect)frame isFavorite:(BOOL)isFavorite;



@end
