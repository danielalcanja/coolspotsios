//
//  CSSharedData.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/11/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSUser.h"

@interface CSSharedData : NSObject

@property (strong, atomic) NSString *currentCountryCode;
@property (strong, atomic) NSString *currentCountry;
@property (strong, atomic) NSString *currentState;
@property (strong, atomic) NSString *currentCity;
@property (strong, atomic) NSMutableArray *nearLocations;
@property (strong, atomic) CSUser *currentUser;

+ (id)sharedInstance;


@end
