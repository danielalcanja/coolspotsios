//
//  BackButton.m
//  Paybill
//
//  Created by Daniel Alcanja on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BackButton.h"

#define MAX_BACK_BUTTON_WIDTH 160.0

@implementation BackButton



-(UIButton*) backButtonWith:(UIImage*)backButtonImage withTtle:(NSString *)title leftCapWidth:(CGFloat)capWidth
{
    // store the cap width for use later when we set the text
    backButtonCapWidth = capWidth;
    
    // Create stretchable images for the normal and highlighted states
    UIImage* buttonImage = [backButtonImage stretchableImageWithLeftCapWidth:backButtonCapWidth topCapHeight:0.0];
    // Create a custom button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Set the title to use the same font and shadow as the standard back button
    button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    button.titleLabel.textColor = [UIColor blackColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
   
    //button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    //button.titleLabel.shadowColor = [UIColor darkGrayColor];
    
    // Set the break mode to truncate at the end like the standard back button
    button.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
    
    // Inset the title on the left and right
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 6.0, 0, 3.0);
    
    // Make the button as high as the passed in image
    button.frame = CGRectMake(0, 0, 0, buttonImage.size.height);
    
    // Just like the standard back button, use the title of the previous item as the default back text
    [self setText:title onBackButton:button];
    
    // Set the stretchable images as the background for the button
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    
    // Add an action for going back
    //[button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

// Set the text on the custom back button
-(void) setText:(NSString*)text onBackButton:(UIButton*)backButton
{
    // Measure the width of the text
    CGSize textSize = [text sizeWithFont:backButton.titleLabel.font];
    // Change the button's frame. The width is either the width of the new text or the max width
    backButton.frame = CGRectMake(backButton.frame.origin.x, backButton.frame.origin.y, (textSize.width + (backButtonCapWidth * 1.5)) > MAX_BACK_BUTTON_WIDTH ? MAX_BACK_BUTTON_WIDTH : (textSize.width + (backButtonCapWidth * 1.5)), backButton.frame.size.height);
    
    // Set the text on the button
    [backButton setTitle:text forState:UIControlStateNormal];
}

@end