//
//  CSAPI.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/7/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSAPI.h"
#import <AFNetworking.h>
#import <RestKit.h>


@implementation CSAPI

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(void)jsonRequestWithParameters:(NSDictionary*)parameters path:(NSString*)path success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.coolspots.com.br"]];
    
    [client setParameterEncoding:AFJSONParameterEncoding];
    [client postPath:path parameters:parameters success:success failure:failure];
}
-(void)getBestLocationsWithPage:(NSNumber*)page delegate:(id<CSLocationDelegate>)delegate {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:page forKey:@"page"];
    
    [self jsonRequestWithParameters:parameters path:@"/json/location" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        
        NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"data"] mutableCopy];
        NSMutableArray *dictionary = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[tempObjects count];i++) {
            
            CSLocation *location = [[CSLocation alloc] init];
            location.id = [[tempObjects valueForKey:@"id"][i] intValue];
            location.name =[tempObjects valueForKey:@"name"][i];
            
            NSMutableArray *pics = [tempObjects valueForKey:@"lastPhotos"][i];
            for(int i=0;i<[pics count];i++) {
                
                CSPic *pic = [[CSPic alloc] init];
                pic.standard_resolution = [pics valueForKey:@"standard_resolution"][i];
                pic.thumbnail = [pics valueForKey:@"thumbnail"][i];
                pic.low_resolution = [pics valueForKey:@"low_resolution"][i];
                location.pics  = [[NSMutableArray alloc] init];
                [location.pics addObject:pic];
            }
            
            [dictionary addObject:location];
            
        }
        
        [delegate getBestLocationsSucceeded:dictionary];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [delegate getBestLocations:error];
    }];
    
    
}
@end
