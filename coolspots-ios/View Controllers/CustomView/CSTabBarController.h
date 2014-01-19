//
//  CSTabBarController.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/27/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSRootViewController.h"
#import "CSExploreViewController.h"
#import "CSEventsViewController.h"
#import "CSFavoritesViewController.h"
#import "CSLocationsViewController.h"

@interface CSTabBarController : UITabBarController

@property (strong, nonatomic) CSLocationsViewController *mainViewController;
@property (strong, nonatomic) CSRootViewController *rootViewController;
@property (strong, nonatomic) CSEventsViewController *eventsViewController;
@property (strong, nonatomic) CSRootViewController *exploreViewController;
@property (strong, nonatomic) CSFavoritesViewController   *favoritesViewController;

@end
