//
//  CSLocationDetailViewController2.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 5/6/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "CSLocationCollectionViewCell3.h"
#import "CSInfoLocationCollectionViewCell.h"
#import "APIInstagram.h"
#import "CSPic.h"
#import <DejalActivityView.h>
#import "AppDelegate.h"
#import "XLMediaZoom.h"


@interface CSLocationDetailViewController2 : UIViewController<CSGetMediaCaller,UICollectionViewDataSource, UICollectionViewDelegate>

@property  (nonatomic,strong) Location *location;
@property (strong) NSMutableArray *picObjects;
@property (strong) NSString *maxID;
@property (strong, nonatomic) XLMediaZoom *imageZoomView;


@end
