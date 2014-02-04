//
//  CSPic.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 12/19/13.
//  Copyright (c) 2013 coolspots. All rights reserved.
//

#import "CSPic.h"

@implementation CSPic

- (Class)AMCElementClassForCollectionWithKey:(NSString*)key {
    if ([@"data" isEqualToString:key]) {
        return [CSPic class];
    }
    return [NSObject class];
}



@end
