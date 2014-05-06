//
//  CoolSpotsAPI.h
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/30/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GFClient.h>
#import "CSLocation.h"
#import "CSGeo.h"
#import "CSParameter.h"
#import "CSPic.h"
#import "CSResponse.h"
#import "Location.h"
#import "User.h"

// Logging
@protocol LoggingUserCaller<NSObject>
@required
- (void) loggingUserSucceeded:(CSResponse*)response;
- (void) loggingUserError:(NSError*)error;
- (void) unauthorizedError:(NSError*)error;
@end

@protocol AddUserCaller<NSObject>
@required
- (void) addUserSucceeded:(CSResponse*)response;
- (void) addUserError:(NSError*)error;
@end

// location
@protocol GetLocationsDelegateCaller<NSObject>
@required
- (void) getLocationsSucceeded:(NSArray*)response;
- (void) getLocationsError:(NSError*)error;
@end

// json/location
@protocol CSLocationsDelegateCaller<NSObject>
@required
- (void) getLocationsSucceeded:(CSResponse*)response;
- (void) getLocationsError:(NSError*)error;
@end

// Add
@protocol AddLocationCaller<NSObject>
@required
- (void) addLocationSucceeded:(NSArray*)response;
- (void) addLocationError:(NSError*)error;
@end

// json/location/photos
@protocol CSPhotosDelegateCaller<NSObject>
@required
- (void) getPhotosSucceeded:(CSResponse*)response;
- (void) getPhotosError:(NSError*)error;
@end

// json/favorities
@protocol CSFavoriteDelegateCaller<NSObject>
@required
- (void) getLocationsSucceeded:(CSResponse*)response;
- (void) getLocationsError:(NSError*)error;
@end

@interface CoolSpotsAPI : NSObject

@property (strong, nonatomic) GFClient *gf;
+ (id)sharedInstance;

-(void)getLocationsWithPage:(NSNumber*)page city:(NSString*)city category:(NSString*)category countryName:(NSString*)countryName stateName:(NSString*)stateName delegate:(id<CSLocationsDelegateCaller>)delegate;
-(void)getPhotosWithID:(NSNumber*)idLocation page:(NSNumber*)page delegate:(id<CSPhotosDelegateCaller>)delegate;
-(void)getLocationsWithCity:(NSString*)city delegate:(id<GetLocationsDelegateCaller>)delegate;
- (void)addLocationWithLocation:(Location*)location delegate:(id<AddLocationCaller>)delegate;

-(void)loggingInWithUsername:(NSString*)username password:(NSString*)password delegate:(id<LoggingUserCaller>)delegate;
-(void)addUserWithUsername:(NSString*)username password:(NSString*)password fullname:(NSString*)fullname pic:(NSString*)pic bio:(NSString*)bio delegate:(id<AddUserCaller>)delegate;

@end
