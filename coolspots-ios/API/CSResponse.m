//
//  CSResponse.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/30/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSResponse.h"
#import "CSLocation.h"

@implementation CSResponse

- (Class)AMCElementClassForCollectionWithKey:(NSString*)key {
    if ([key isEqualToString:@"data"]) {
        return [CSLocation class];
    }
    return [NSObject class];
}

@end
