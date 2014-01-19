//
//  CSFavButton.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/19/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSFavButton.h"

@implementation CSFavButton

- (id)initWithFrame:(CGRect)frame isFavorite:(BOOL)isFavorite
{
    self = [super initWithFrame:frame];
    if (self) {

        CGRect frambutton = frame;
        frambutton.origin.x = 0;
        frambutton.origin.y = 0;
        self.isFavorite = isFavorite;
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = frambutton;
        self.button.backgroundColor = [UIColor clearColor];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        UIImage *buttonImageNormalFallow = [UIImage imageNamed:@"button-bookmark"];
        if(self.isFavorite) {
            buttonImageNormalFallow = [UIImage imageNamed:@"button-bookmark-on"];
        }
        UIImage *strechableButtonImageNormalFallow = [buttonImageNormalFallow stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [self.button setBackgroundImage:strechableButtonImageNormalFallow forState:UIControlStateNormal];
        
        [self addSubview:self.button];
        
    }
    return self;
}



@end
