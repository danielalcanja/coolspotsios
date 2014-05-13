//
//  AppDelegate.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/17/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "AppDelegate.h"
#import "CSNavigationController.h"
#import "GTScrollNavigationBar.h"
#import "CSLoginViewController.h"
#import "CSWelcomeViewController.h"
#import "CSNavigationController.h"
#import <GFClient.h>


#define MIXPANEL_TOKEN @"afc6f3a3605c0f7a10c5f5a76c7a586d"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if TARGET_IPHONE_SIMULATOR
    [[DCIntrospect sharedIntrospector] start];
#endif
    
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    
    NSURL *baseURL = [NSURL URLWithString:@"http://107.170.132.4/"]; // the base URL of your API
    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    // initialize GoldenFleece
    GFClient __unused *gf = [GFClient createWithHttpClient:client];


    //API INSTAGRAM
    // initialize HTTPClient
    NSURL *baseURL3 = [NSURL URLWithString:@"https://api.instagram.com/v1/"];
    AFHTTPClient* client3 = [[AFHTTPClient alloc] initWithBaseURL:baseURL3];
    // initialize GoldenFleece
    GFClient __unused *gfInstagram = [[GFClient alloc] initWithHttpClient:client3];
    self.apiInstagram = [[APIInstagram alloc] initWithGFClient:gfInstagram];
    
    
    self.instagram = [[Instagram alloc] init];

 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //[self.instagram logout];
    [Crashlytics startWithAPIKey:@"bf801b7bbff2efa6f6be22b50c82f0325652fe5c"];
    
    if ([self.instagram isSessionValid]) {

        CSTabBarController *tabBarController = [[CSTabBarController alloc] init];
        self.window.rootViewController = tabBarController;
        
        
    }else {
        
        CSWelcomeViewController *welcomScreen = [[CSWelcomeViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:welcomScreen];
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-login"] forBarMetrics:UIBarMetricsDefault];

        self.window.rootViewController = navController;
        
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
