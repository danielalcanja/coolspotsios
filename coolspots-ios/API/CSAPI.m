//
//  CSAPI.m
//  coolspots-ios
//
//  Created by Daniel Alcanja on 1/7/14.
//  Copyright (c) 2014 coolspots. All rights reserved.
//

#import "CSAPI.h"
#import <AFNetworking.h>

@implementation CSAPI {
    
    dispatch_queue_t backgroundQueue;

}

- (void) jsonRequestWithParameters:(NSDictionary*)parameters
                              path:(NSString*)path
                            method:(NSString*)method
                     expectedClass:(Class)class
                           success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id object))success
                           failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
                        background:(BOOL)background {
    NSMutableURLRequest *request = [self.httpClient requestWithMethod:method path:path parameters:parameters];
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        failure(request, response, error);
                                                    }];
    if (self.additionalAcceptableContentTypes) {
        [AFJSONRequestOperation addAcceptableContentTypes:self.additionalAcceptableContentTypes];
    }
    if (background) {
        [operation setSuccessCallbackQueue:backgroundQueue];
    }
    [operation start];
}

@end
