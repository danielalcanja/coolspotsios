//
//  CSAPI.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/7/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "CSLocation.h"
#import "CSPic.h"

@protocol CSLocationDelegate<NSObject>
@required
- (void) getBestLocationsSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getBestLocations:(NSError*)error;
@end

@interface CSAPI : NSObject

+ (id)sharedInstance;

-(void)getBestLocationsWithPage:(NSNumber*)page delegate:(id<CSLocationDelegate>)delegate;

@end
