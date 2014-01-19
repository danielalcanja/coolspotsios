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

        self.isFavorite = isFavorite;

        CGRect frambutton = frame;
        frambutton.origin.x = 0;
        frambutton.origin.y = 0;
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = frambutton;
        self.button.backgroundColor = [UIColor clearColor];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        [self setupButton:isFavorite];
        [self.button addTarget:self action:@selector(favorite:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
    }
    return self;
}
-(void)setupButton:(BOOL)isFavorite {
    
    UIImage *buttonImageNormalFallow = [UIImage imageNamed:@"button-bookmark"];
    if(isFavorite) {
        buttonImageNormalFallow = [UIImage imageNamed:@"button-bookmark-on"];
    }
    
    [self.button setBackgroundImage:buttonImageNormalFallow forState:UIControlStateNormal];
}
-(void)reloadControlWithIdLocation:(NSString*)idLocation isFavorite:(BOOL)isFavorite{

    self.idLocation = idLocation;
    self.isFavorite = isFavorite;
    
    [self setupButton:isFavorite];
    
}
-(IBAction)favorite:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self setupButton:!self.isFavorite];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *username = [prefs stringForKey:@"username"];
    
    [[CSAPI sharedInstance] addFavoriteLocationWithLocationID:self.idLocation username:username delegate:self];
    
}
-(void)addFavoriteLocationSucceeded:(NSMutableArray *)dictionary {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(void)addFavoriteLocationError:(NSError *)error {
    
    NSLog(@"addFavoriteLocationError %@", error );
    
}

@end
