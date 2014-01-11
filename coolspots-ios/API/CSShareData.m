//
//  CSShareData.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/9/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSShareData.h"

@implementation CSShareData
+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

@end
