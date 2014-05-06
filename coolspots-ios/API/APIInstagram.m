//
//  APIInstagram.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 4/10/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "APIInstagram.h"
#import "AFHTTPClient.h"
#import <NSObject+GFJson.h>

@implementation APIInstagram

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
/**
 * getMedia
 */
- (void)getMediaWithID:(NSString*)idmedia MAX_ID:(NSString*)next_max_id delegate:(id<CSGetMediaCaller>)delegate
{
    NSString *path = [NSString stringWithFormat:@"locations/%@/media/recent/", idmedia];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *access_token= [prefs stringForKey:@"access_token"];
    NSString *paramenter = @"";
    if(next_max_id) {
        paramenter = [NSString stringWithFormat:@"&max_id=%@", next_max_id];
    }
    
    
    [self jsonRequestWithParameters:nil
                               path:[NSString stringWithFormat:@"%@?access_token=%@%@", path,access_token,paramenter]
                             method:@"GET"
                      expectedClass:[NSDictionary class]
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id object) {
                                NSDictionary *msResponse = (NSDictionary*)object;
                                [delegate getMediaSucceeded:msResponse];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                
                                [delegate getMediaError:error];
                                
                            }
     ];
}

@end
