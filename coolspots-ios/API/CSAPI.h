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
#import "CSUser.h"

// InstagramUserID
@protocol CSInstagramUserInfoDelegate<NSObject>
@required
- (void) getInstagramUserInfoSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getInstagramUserInfoError:(NSError*)error;
@end
// InstagramIDLocation
@protocol CSInstagramIDLocationDelegate<NSObject>
@required
- (void) getInstagramIDLocationSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getInstagramIDLocationError:(NSError*)error;
@end
// treding/location
@protocol CSTredingLocationDelegate<NSObject>
@required
- (void) getTredingLocationsSucceeded:(NSDictionary*)dictionary;
@optional
- (void) getTredingLocationsError:(NSError*)error;
@end
// json/favorites
@protocol CSFavoriteLocationsDelegate<NSObject>
@required
- (void) getFavoriteLocationsSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getFavoriteLocationsError:(NSError*)error;
@end
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
// json/location
@protocol CSAddLocationDelegate<NSObject>
@required
- (void) getAddLocationSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getAddLocationError:(NSError*)error;
@end
// /json/photos
@protocol CSPhotosDelegate<NSObject>
@required
- (void) getPhotosSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) getPhotosError:(NSError*)error;
@end
// /json/users/add
@protocol CSAddUserDelegate<NSObject>
@required
- (void) addUserSucceeded:(NSMutableArray*)dictionary;
@optional
- (void) addUserError:(NSError*)error;
@end

@interface CSAPI : NSObject

+ (id)sharedInstance;

-(void)getBestLocationsWithPage:(NSNumber*)page city:(NSString*)city delegate:(id<CSLocationDelegate>)delegate ;
-(void)getPhotosWithID:(NSNumber*)idLocation page:(NSNumber*)page delegate:(id<CSPhotosDelegate>)delegate;
-(void)getTredingLocationWithDelegate:(id<CSTredingLocationDelegate>)delegate;
-(void)getFavoriteLocationsWithPage:(NSNumber*)page username:(NSString*)username delegate:(id<CSFavoriteLocationsDelegate>)delegate;
-(void)getInstagramIDLocationWithFoursquareID:(NSString*)foursquareID delegate:(id<CSTredingLocationDelegate>)delegate;
-(void)getInstagramUserInfoWithToken:(NSString*)token delegate:(id<CSInstagramUserInfoDelegate>)delegate;
-(void)addLocationWithDictionary:(NSMutableDictionary*)dictionary delegate:(id<CSAddLocationDelegate>)delegate;
-(void)addUserWithUser:(CSUser*)user token:(NSString*)token delegate:(id<CSAddUserDelegate>)delegate;
@end
