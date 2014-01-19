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
#import "CSAPI.h"
#import "NewCityViewController.h"


@interface CSRootViewController : UIViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MosaicLayoutDelegate,CLLocationManagerDelegate,CSLocationDelegate>
{
    __weak IBOutlet UICollectionView *_collectionView;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NewCityViewController *newCityViewController;
}


@end
