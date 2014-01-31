//
//  CSLocation.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/19/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSLocation.h"
#import "CSPic.h"

@implementation CSLocation

- (Class)AMCElementClassForCollectionWithKey:(NSString*)key {
    if ([@"data" isEqualToString:key]) {
        return [CSLocation class];
    }
    return [NSObject class];
}
- (NSDictionary*)jsonClasses {
    return @{
             @"lastPhotos" : [CSPic class],@"id" : @"idLocation"
             };
}

@end
