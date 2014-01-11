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

// json/location
@protocol CSLocationDelegate<NSObject>
@required
- (void) getBestLocationsSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getBestLocations:(NSError*)error;
@end
// /json/locationinfo
@protocol CSLocationInfoDelegate<NSObject>
@required
- (void) getBestLocationsInfoSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getBestLocationInfo:(NSError*)error;
@end
// /json/photos
@protocol CSPhotosDelegate<NSObject>
@required
- (void) getPhotosSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getPhotosError:(NSError*)error;
@end



@interface CSAPI : NSObject

+ (id)sharedInstance;

-(void)getBestLocationsWithPage:(NSNumber*)page delegate:(id<CSLocationDelegate>)delegate;
-(void)getLocationInfoWithID:(NSNumber*)idLocation delegate:(id<CSLocationInfoDelegate>)delegate;
-(void)getPhotosWithID:(NSNumber*)idLocation page:(NSNumber*)page delegate:(id<CSPhotosDelegate>)delegate;

@end
