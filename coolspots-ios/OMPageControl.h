//
//  OMPageControl.h
//  Paybill
//
//  Created by Daniel Alcanja on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMPageControl : UIPageControl {
    UIImage* mImageNormal;
    UIImage* mImageCurrent;
}

@property (nonatomic, readwrite, retain) UIImage* imageNormal;
@property (nonatomic, readwrite, retain) UIImage* imageCurrent;

@end