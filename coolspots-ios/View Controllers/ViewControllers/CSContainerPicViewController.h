//
//  CSContainerPicViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/23/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"


@interface CSContainerPicViewController : UIViewController

@property (assign, nonatomic) NSMutableArray *picObjects;
@property (nonatomic, assign) NSInteger  index;
@property  (nonatomic,strong) Location *location;




@end
