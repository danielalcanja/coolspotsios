//
//  CSImageView.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/31/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSImageView : UIView {
    
    UIImageView *_imageView;
}

-(void)setURL:(NSString *)imageURL;

@end
