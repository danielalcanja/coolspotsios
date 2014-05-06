//
//  CSCommentButton.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/26/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLocation.h"

@interface CSCommentButton : UIView
@property   (strong) UIButton *button;

-(void)reloadControlWithLocation:(CSLocation*)location controller:(UIViewController *)controller;


@end
