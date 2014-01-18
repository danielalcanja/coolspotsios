//
//  Instagram.m
//  bestspots
//
//  Created by Daniel Alcanja on 2/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Instagram.h"
static NSString* kDialogBaseURL = @"https://instagram.com/";

@implementation Instagram

@synthesize accessToken;


- (BOOL)isSessionValid {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    return ([prefs stringForKey:@"access_token"] != nil);
    
}
- (void)logout {
    [self invalidateSession];
}

#pragma mark - internal

-(void)invalidateSession {
    self.accessToken = nil;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"access_token"];
    [prefs synchronize];
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* instagramCookies = [cookies cookiesForURL:[NSURL URLWithString:kDialogBaseURL]];
    
    for (NSHTTPCookie* cookie in instagramCookies) {
        [cookies deleteCookie:cookie];
    }
}

@end
