//
//  CSSearchFoursquareViewController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/21/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAPI.h"
#import <DejalActivityView.h>
#import <CoreLocation/CoreLocation.h>
#import "CoolSpotsAPI.h"


@interface CSSearchFoursquareViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchDisplayDelegate,CSFSVenusNearDelegate,CLLocationManagerDelegate,CSInstagramIDLocationDelegate,CSAddLocationDelegate,UISearchBarDelegate,AddLocationCaller>

@property  (nonatomic,strong) NSString *locationCity;

-(void)reloadData;


@end
