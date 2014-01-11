//
//  CSRootViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/19/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSUtil.h"
#import <AMScrollingNavbarViewController.h>
#import <DejalActivityView.h>
#import <EGORefreshTableHeaderView.h>
#import <YIFullScreenScroll.h>
#import "MosaicLayoutDelegate.h"
#import <CoreLocation/CoreLocation.h>


#define kColumnsiPadLandscape 5
#define kColumnsiPadPortrait 4
#define kColumnsiPhoneLandscape 3
#define kColumnsiPhonePortrait 2

@interface CSRootViewController : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MosaicLayoutDelegate,CLLocationManagerDelegate>
{
    __weak IBOutlet UICollectionView *_collectionView;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}


@end