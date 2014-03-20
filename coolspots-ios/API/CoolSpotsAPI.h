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


// json/location
@protocol CSLocationsDelegateCaller<NSObject>
@required
- (void) getLocationsSucceeded:(CSResponse*)response;
- (void) getLocationsError:(NSError*)error;
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

@end
