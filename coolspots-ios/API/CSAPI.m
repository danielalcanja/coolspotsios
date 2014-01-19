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
#import "CSSharedData.h"
#import "CSUser.h"

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

-(void)jsonRequestOperationWithParameters:(NSDictionary*)parameters baseURL:(NSURL*)url success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                            failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:success failure:failure];
    
    [operation start];

}

-(void)tredingLocationJsonRequestOperationWithParameters:(NSDictionary*)parameters success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                  failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure {
    
    NSString *city = [[CSSharedData sharedInstance] currentCity];
    NSString *state = [[CSSharedData sharedInstance] currentState];

    NSString *weatherUrl = [NSString stringWithFormat:@"http://igrejas.mobi/thecoolspots/RTU/index.php?city=%@,%@", city, state];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    
    [self jsonRequestOperationWithParameters:parameters baseURL:url success:success failure:failure];
    
}

-(void)getInstagramIDJsonRequestOperationWithFoursquareID:(NSString*)foursquareID success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                                 failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure {
    
    NSString *weatherUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/locations/search?foursquare_v2_id=%@&client_id=%@", foursquareID, @"ff47f1dcba9d44868038a2b3f610a6dc"];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    
    [self jsonRequestOperationWithParameters:nil baseURL:url success:success failure:failure];
    
}
-(void)getInstagramUserInfoJsonRequestOperationWithToken:(NSString*)token success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                                  failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure {
    
    NSString *weatherUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self?access_token=%@", token];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    
    [self jsonRequestOperationWithParameters:nil baseURL:url success:success failure:failure];
    
}

-(void)httpRequestWithParameters:(NSDictionary*)parameters baseURL:(NSURL*)url path:(NSString*)path success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    [client setParameterEncoding:AFJSONParameterEncoding];
    [client postPath:path parameters:parameters success:success failure:failure];
    
}

-(void)httpRequestWithParameters:(NSDictionary*)parameters path:(NSString*)path success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    [self httpRequestWithParameters:parameters baseURL:[NSURL URLWithString:@"http://api.coolspots.com.br"] path:path success:success failure:failure];
}
-(void)getBestLocationsWithPage:(NSNumber*)page city:(NSString*)city delegate:(id<CSLocationDelegate>)delegate {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:page forKey:@"page"];
    [parameters setObject:city forKey:@"city"];

    
    [self httpRequestWithParameters:parameters path:@"/json/locations" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        
        NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"data"] mutableCopy];
        NSMutableArray *dictionary = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[tempObjects count];i++) {
            
            CSLocation *location = [[CSLocation alloc] init];
            location.id = [[tempObjects valueForKey:@"id"][i] intValue];
            location.name =[tempObjects valueForKey:@"name"][i];
            location.isFavorite = NO;

            
            NSMutableArray *pics = [tempObjects valueForKey:@"lastPhotos"][i];
            location.pics  = [[NSMutableArray alloc] init];

            for(int i=0;i<[pics count];i++) {
                
                CSPic *pic = [[CSPic alloc] init];
                pic.standard_resolution = [pics valueForKey:@"standard_resolution"][i];
                pic.thumbnail = [pics valueForKey:@"thumbnail"][i];
                pic.low_resolution = [pics valueForKey:@"low_resolution"][i];
                pic.caption = [pics valueForKey:@"caption"][i];

                [location.pics addObject:pic];
            }
            
            [dictionary addObject:location];
        }
        
        [delegate getBestLocationsSucceeded:dictionary];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [delegate getBestLocations:error];
    }];
}
-(void)getEventsWithPage:(NSNumber*)page city:(NSString*)city delegate:(id<CSEventsDelegate>)delegate {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:page forKey:@"page"];
    [parameters setObject:city forKey:@"city"];
    
    [self httpRequestWithParameters:parameters path:@"/json/events" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        
        NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"data"] mutableCopy];
        NSMutableArray *dictionary = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[tempObjects count];i++) {
            
            CSLocation *location = [[CSLocation alloc] init];
            location.id = [[tempObjects valueForKey:@"id"][i] intValue];
            location.name =[tempObjects valueForKey:@"name"][i];
            location.isFavorite = NO;
            
            
            NSMutableArray *pics = [tempObjects valueForKey:@"lastPhotos"][i];
            location.pics  = [[NSMutableArray alloc] init];
            
            for(int i=0;i<[pics count];i++) {
                
                CSPic *pic = [[CSPic alloc] init];
                pic.standard_resolution = [pics valueForKey:@"standard_resolution"][i];
                pic.thumbnail = [pics valueForKey:@"thumbnail"][i];
                pic.low_resolution = [pics valueForKey:@"low_resolution"][i];
                pic.caption = [pics valueForKey:@"caption"][i];
                
                [location.pics addObject:pic];
            }
            
            [dictionary addObject:location];
        }
        
        [delegate getEventsSucceeded:dictionary];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [delegate getEventsError:error];
    }];
}
-(void)getFavoriteLocationsWithPage:(NSNumber*)page username:(NSString*)username delegate:(id<CSFavoriteLocationsDelegate>)delegate {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:page forKey:@"page"];
    [parameters setObject:username forKey:@"username"];
    
    
    [self httpRequestWithParameters:parameters path:@"/json/favorites" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        
        NSMutableArray *dictionary = [[NSMutableArray alloc] init];

        if(![[parsedResponse objectForKey:@"data"]  isEqual:[NSNull null]]) {

            NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"data"] mutableCopy];
            
            for(int i=0;i<[tempObjects count];i++) {
                
                NSMutableArray *favoritesList = [tempObjects valueForKey:@"idLocation"][i];
                
                CSLocation *location = [[CSLocation alloc] init];
                location.id = [[favoritesList valueForKey:@"id"] intValue];
                location.name =[favoritesList valueForKey:@"name"];
                location.isFavorite = YES;
                
                //NSMutableArray *pics = [tempObjects valueForKey:@"lastPhotos"][i];
                location.pics  = [[NSMutableArray alloc] init];
                /*
                for(int i=0;i<[pics count];i++) {
                    
                    CSPic *pic = [[CSPic alloc] init];
                    pic.standard_resolution = [pics valueForKey:@"standard_resolution"][i];
                    pic.thumbnail = [pics valueForKey:@"thumbnail"][i];
                    pic.low_resolution = [pics valueForKey:@"low_resolution"][i];
                    pic.caption = [pics valueForKey:@"caption"][i];
                    
                    [location.pics addObject:pic];
                }
                */
                [dictionary addObject:location];
            }
            
        
        }
        
        [delegate getFavoriteLocationsSucceeded:dictionary];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [delegate getFavoriteLocationsError:error];
    }];
}


-(void)getPhotosWithID:(NSNumber*)idLocation page:(NSNumber*)page delegate:(id<CSPhotosDelegate>)delegate {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:idLocation forKey:@"id"];
    [parameters setObject:page forKey:@"page"];
    
    [self httpRequestWithParameters:parameters path:@"/json/locations/photos" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        
        NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"data"] mutableCopy];
        
        NSMutableArray *dictionary = [[NSMutableArray alloc] init];
        
        for(int i=0;i<[tempObjects count];i++) {
            
            CSPic *pic = [[CSPic alloc] init];
            pic.standard_resolution = [tempObjects valueForKey:@"standardResolution"][i];
            pic.thumbnail = [tempObjects valueForKey:@"thumbnail"][i];
            pic.low_resolution = [tempObjects valueForKey:@"lowResolution"][i];
            pic.caption = [tempObjects valueForKey:@"caption"][i];

            
            [dictionary addObject:pic];
        }
        
        [delegate getPhotosSucceeded:dictionary];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [delegate getPhotosError:error];
    }];
    
}

-(void)getTredingLocationWithDelegate:(id<CSTredingLocationDelegate>)delegate {
    
    [self tredingLocationJsonRequestOperationWithParameters:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *temDic = (NSDictionary *)JSON;
        [delegate getTredingLocationsSucceeded:temDic];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [delegate getTredingLocationsError:error];
    }];
    
}
-(void)getInstagramIDLocationWithFoursquareID:(NSString*)foursquareID delegate:(id<CSInstagramIDLocationDelegate>)delegate {
    
    [self getInstagramIDJsonRequestOperationWithFoursquareID:foursquareID success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSMutableArray *tempObjects = [[JSON objectForKey:@"data"] mutableCopy];
        [delegate getInstagramIDLocationSucceeded:tempObjects];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        [delegate getInstagramIDLocationError:error];
        
    }];
}
-(void)getInstagramUserInfoWithToken:(NSString*)token delegate:(id<CSInstagramUserInfoDelegate>)delegate {
    
    [self getInstagramUserInfoJsonRequestOperationWithToken:token success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSMutableArray *tempObjects = [[JSON objectForKey:@"data"] mutableCopy];
        [delegate getInstagramUserInfoSucceeded:tempObjects];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        [delegate getInstagramUserInfoError:error];
        
    }];
}


-(void)addLocationWithDictionary:(NSMutableDictionary*)dictionary delegate:(id<CSAddLocationDelegate>)delegate {
    
    [self httpRequestWithParameters:dictionary path:@"/json/locations/add" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"meta"] mutableCopy];
        [delegate getAddLocationSucceeded:tempObjects];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [delegate getAddLocationError:error];
        
    }];    
}

-(void)addRemoveFavoriteLocationWithLocationID:(NSString*)idlocation username:(NSString*)username delegate:(id<CSAddRemoveFavoriteLocationDelegate>)delegate remove:(BOOL)isRemove {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:idlocation forKey:@"id_location"];
    [parameters setValue:username forKey:@"username"];
    
    NSString *path = @"/json/favorites/add";
    if(isRemove) {
        path = @"/json/favorites/remove";
    }
    
    [self httpRequestWithParameters:parameters path:path success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"meta"] mutableCopy];
        [delegate addRemoveFavoriteLocationSucceeded:tempObjects];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [delegate addRemoveFavoriteLocationError:error];
        
    }];
    
}

-(void)addUserWithUser:(CSUser*)user token:(NSString*)token delegate:(id<CSAddUserDelegate>)delegate {
    
    NSMutableDictionary *dicUser = [[NSMutableDictionary alloc]init];
    [dicUser setValue:user.id forKey:@"id"];
    [dicUser setValue:user.username forKey:@"username"];
    [dicUser setValue:user.full_name forKey:@"full_name"];
    [dicUser setValue:user.profile_picture forKey:@"profile_picture"];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:token forKey:@"access_token"];
    [parameters setObject:dicUser forKey:@"user"];
    
    [self httpRequestWithParameters:parameters path:@"/json/users/add" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /*
        NSData *responseData = operation.responseData;
        id parsedResponse = [RKMIMETypeSerialization objectFromData:responseData MIMEType:RKMIMETypeJSON error:nil];
        NSMutableArray *tempObjects = [[parsedResponse objectForKey:@"meta"] mutableCopy];
         */
        [delegate addUserSucceeded:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [delegate addUserError:error ];
    }];
    
    
}
@end
