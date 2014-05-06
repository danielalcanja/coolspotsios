//
//  AppDelegate.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/17/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DCIntrospect.h>
#import <Mixpanel.h>
#import "CSTabBarController.h"
#import "Instagram.h"
#import <GFClient.h>
#import "APIInstagram.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Instagram *instagram;
@property (nonatomic, strong) APIInstagram* apiInstagram;




@end
