//
//  CSFavButton.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/19/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAPI.h"


@interface CSFavButton : UIView<CSAddFavoriteLocationDelegate>

@property   (assign) UIButton *button;
@property (assign) BOOL isFavorite;
@property  (nonatomic,strong) NSString *idLocation;

- (id)initWithFrame:(CGRect)frame isFavorite:(BOOL)isFavorite;
-(void)reloadControlWithIdLocation:(NSString*)idLocation isFavorite:(BOOL)isFavorite;


@end
