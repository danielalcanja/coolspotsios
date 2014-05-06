//
//  CoolSpotsAPI.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/30/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CoolSpotsAPI.h"
#import <NSObject+GFJson.h>


@implementation CoolSpotsAPI

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (!self.gf) {
        self.gf = [GFClient sharedInstance];
    }
    return self;
}

- (id)initWithGFClient:(GFClient*)gfClient {
    self = [super init];
    [self setGf:gfClient];
    return self;
}
- (void) jsonRequestWithParameters:(NSObject*)obj
                              path:(NSString*)path
                            method:(NSString*)method
                     expectedClass:(Class)class
                           success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id object))success
                           failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
{
    [self.gf jsonRequestWithObject:obj
                                  path:path method:method
                         expectedClass:class
                               success:success
                               failure:failure];
    
    
}
-(void)addUserWithUsername:(NSString*)username password:(NSString*)password fullname:(NSString*)fullname pic:(NSString*)pic bio:(NSString*)bio delegate:(id<AddUserCaller>)delegate{
    
    User *user = [[User alloc] init];
    user.username = username;
    user.password = password;
    user.fullname = fullname;
    user.bio = bio;
    user.profilepicture = pic;
    [self jsonRequestWithParameters:user
                               path:@"/users"
                             method:@"POST"
                      expectedClass:[CSLocation class]
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id object) {
                                CSResponse *result = (CSResponse*)object;
                                [delegate addUserSucceeded:result];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                
                                [delegate addUserError:error];

                                
                            }
     ];
}
-(void)loggingInWithUsername:(NSString*)username password:(NSString*)password delegate:(id<LoggingUserCaller>)delegate{
    
    User *user = [[User alloc] init];
    user.username = username;
    user.password = password;
    
    NSMutableDictionary *userDict = [user jsonObject];
    [userDict removeObjectForKey:@"profilepicture"];
    [userDict removeObjectForKey:@"fullname"];
    [userDict removeObjectForKey:@"bio"];

    [self jsonRequestWithParameters:userDict
                               path:@"/users/login"
                             method:@"POST"
                      expectedClass:[NSDictionary class]
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id object) {
                                NSDictionary *result = (NSDictionary*)object;
                                [delegate loggingUserSucceeded:result];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {

                                if (response.statusCode == 401) {
                                    [delegate unauthorizedError:error];
                                }else {
                                    [delegate loggingUserError:error];
                                }
                                
                            }
     ];
}
-(void)getLocationsWithCity:(NSString*)city delegate:(id<GetLocationsDelegateCaller>)delegate{
   
    [self jsonRequestWithParameters:nil
                               path:[NSString stringWithFormat:@"locations?city=%@", city]
                             method:@"GET"
                      expectedClass:[Location class]
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id object) {
                                NSArray *msResponse = (NSArray*)object;
                                [delegate getLocationsSucceeded:msResponse];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                [delegate getLocationsError:error];
                                
                            }
     ];
}
- (void)addLocationWithLocation:(Location*)location delegate:(id<AddLocationCaller>)delegate
{
    NSString *path = @"locations";
    
    
    [self jsonRequestWithParameters:location
                               path:path
                             method:@"POST"
                      expectedClass:[NSDictionary class]
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id object) {
                                NSArray *msResponse = (NSArray*)object;
                                [delegate addLocationSucceeded:msResponse];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                
                                [delegate addLocationError:error];
                                
                            }
     ];
}


-(void)getLocationsWithPage:(NSNumber*)page city:(NSString*)city category:(NSString*)category countryName:(NSString*)countryName stateName:(NSString*)stateName delegate:(id<CSLocationsDelegateCaller>)delegate{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *username = [prefs stringForKey:@"username"];
    
    CSGeo *geo = [[CSGeo alloc] init];
    geo.cityName = city;
    geo.stateName = stateName;
    geo.countryName = countryName;

    CSParameter *parameter = [[CSParameter alloc] init];
    parameter.username = username;
    parameter.page = page;
    parameter.obj = geo;
    if(category) {
        parameter.category = category;
    }
    [self jsonRequestWithParameters:parameter
                               path:@"/json/locations"
                             method:@"POST"
                      expectedClass:[CSLocation class]
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id object) {
                                CSResponse *result = (CSResponse*)object;
                                [delegate getLocationsSucceeded:result];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                [delegate getLocationsError:error];

                            }
     ];
}
-(void)getPhotosWithID:(NSNumber*)idLocation page:(NSNumber*)page delegate:(id<CSPhotosDelegateCaller>)delegate {
    
    CSParameter *parameter = [[CSParameter alloc] init];
    parameter.id = idLocation;
    parameter.page = page;
    [self jsonRequestWithParameters:parameter
                               path:@"/json/locations/photos"
                             method:@"POST"
                      expectedClass:[CSPic class]
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id object) {
                                CSResponse *result = (CSResponse*)object;
                                [delegate getPhotosSucceeded:result];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                [delegate getPhotosError:error];
                                
                            }
     ];
    
    
}

@end
