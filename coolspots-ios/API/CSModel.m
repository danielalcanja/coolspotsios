//
//  CSModel.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 5/1/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSModel.h"

@implementation CSModel

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(id)init {
    self = [super init];
    if (self) {
        
        
        _assetsThumbnail = [[NSCache alloc]init];
        [_assetsThumbnail setCountLimit:150];
        
        
    }
    return self;
}


@end
