//
//  CSCommentButton.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/26/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSCommentButton.h"
#import "CSCommentsLocationViewController.h"

@implementation CSCommentButton {
    
    UIViewController *_controller;
    CSLocation *_location;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        CGRect frambutton = frame;
        frambutton.origin.x = 0;
        frambutton.origin.y = 0;
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = frambutton;
        self.button.backgroundColor = [UIColor clearColor];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        [self.button setBackgroundImage:[UIImage imageNamed:@"button-comments"] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(goViewComment:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
    
    }
    return self;
}

-(void)reloadControlWithLocation:(CSLocation*)location controller:(UIViewController *)controller{
    
    _controller = controller;
    _location = location;
    
}
-(IBAction)goViewComment:(id)sender {
    
    CSCommentsLocationViewController *goView = [[CSCommentsLocationViewController alloc] init];
    goView.location = _location;
    goView.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [_controller presentViewController:goView animated:YES completion:nil];
    goView.view.superview.bounds = CGRectMake(0, 0, 440, 352);

}

@end
