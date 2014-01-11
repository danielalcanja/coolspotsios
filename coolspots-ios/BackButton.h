//
//  BackButton.h
//  Paybill
//
//  Created by Daniel Alcanja on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackButton : UIButton
{
    CGFloat backButtonCapWidth;
    
}

-(UIButton*) backButtonWith:(UIImage*)backButtonImage withTtle:(NSString *)title leftCapWidth:(CGFloat)capWidth;
-(void) setText:(NSString*)text onBackButton:(UIButton*)backButton;


@end
