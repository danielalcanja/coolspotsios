//
//  CSTabBarController.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/27/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSTabBarController.h"
#import "GTScrollNavigationBar.h"


@interface CSTabBarController ()

@end

@implementation CSTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        self.rootViewController = [[CSRootViewController alloc] init];
        self.eventsViewController = [[CSEventsViewController alloc] init];
        self.exploreViewController = [[CSRootViewController alloc] init];
        self.favoritesViewController = [[CSFavoritesViewController  alloc] init];
                
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
        
        UITabBarItem *tab1 = [[UITabBarItem alloc] initWithTitle:@"Spots" image:[UIImage imageNamed:@"tb-icon-location"] tag:20000];
        navController.tabBarItem  = tab1;
        
        UINavigationController *eventNavController = [[UINavigationController alloc] initWithRootViewController:self.eventsViewController];
        [eventNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-blue"] forBarMetrics:UIBarMetricsDefault];

        
        UITabBarItem *tabEvent = [[UITabBarItem alloc] initWithTitle:@"Events" image:[UIImage imageNamed:@"tb-icon-event"] tag:20001];
        eventNavController.tabBarItem  = tabEvent;
    
        UINavigationController *exploreNavController = [[UINavigationController alloc]  initWithRootViewController: self.exploreViewController];
        [exploreNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-blue"] forBarMetrics:UIBarMetricsDefault];

        
        UITabBarItem *tabExplore = [[UITabBarItem alloc] initWithTitle:@"Explore" image:[UIImage imageNamed:@"tb-icon-explore"] tag:20002];
        exploreNavController.tabBarItem  = tabExplore;
        
        UINavigationController *favoritesNavController = [[UINavigationController alloc]  initWithRootViewController:self.favoritesViewController];
        [favoritesNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bg-blue"] forBarMetrics:UIBarMetricsDefault];

        
        UITabBarItem *tabFav = [[UITabBarItem alloc] initWithTitle:@"Favorites" image:[UIImage imageNamed:@"tb-icon-favorite"] tag:20001];
        favoritesNavController.tabBarItem  = tabFav;
        
        self.viewControllers = [NSArray arrayWithObjects: navController,eventNavController,exploreNavController,favoritesNavController, nil];
        
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
