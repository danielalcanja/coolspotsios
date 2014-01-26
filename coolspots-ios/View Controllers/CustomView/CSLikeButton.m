//
//  CSLikeButton.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/26/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSLikeButton.h"

@implementation CSLikeButton

- (id)initWithFrame:(CGRect)frame isLiked:(BOOL)isLiked
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isLiked = isLiked;
        
        CGRect frambutton = frame;
        frambutton.origin.x = 0;
        frambutton.origin.y = 0;
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = frambutton;
        self.button.backgroundColor = [UIColor clearColor];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        [self setupButton:isLiked];
        [self.button addTarget:self action:@selector(favorite:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
    }
    return self;
}
-(void)setupButton:(BOOL)isLiked {
    
    UIImage *buttonImageNormalFallow = [UIImage imageNamed:@"button-bookmark"];
    if(isLiked) {
        buttonImageNormalFallow = [UIImage imageNamed:@"button-bookmark-on"];
    }
    
    [self.button setBackgroundImage:buttonImageNormalFallow forState:UIControlStateNormal];
}
-(void)reloadControlWithPic:(CSPic*)pic isLiked:(BOOL)isLiked{
    
    self.pic = pic;
    self.isLiked = isLiked;
    
    [self setupButton:isLiked];
    
}
-(IBAction)favorite:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self setupButton:!self.isLiked];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *username = [prefs stringForKey:@"username"];
    
    [[CSAPI sharedInstance] addRemoveLikeWithPic:self.pic username:username delegate:self remove:self.isLiked];
    
}
-(void)addRemoveLikeSucceeded:(NSMutableArray *)dictionary {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}
-(void)addRemoveLikeError:(NSError *)error {
    
    NSLog(@"addRemoveLikeError %@", error );
    
}
@end
